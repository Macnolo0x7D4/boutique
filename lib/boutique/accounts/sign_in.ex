defmodule Boutique.Accounts.SignIn do
  use Boutique, :use_case

  alias Boutique.Accounts
  alias Boutique.Accounts.Crypto

  def call(%{email: email, password: password}) do
    expires_at = DateTime.utc_now() |> DateTime.add(24, :hour) |> DateTime.to_unix()

    with {:ok, account} <- Accounts.get_account_by_email(email),
         :ok <- validate_password(password, account.hashed_password),
         {:ok, token} <- Crypto.generate_token(%{sub: account.id, exp: expires_at}) do
      {:ok, token, account}
    else
      {:error, :account_not_found} -> {:error, :account_not_found}
      :error -> {:error, :invalid_credentials}
      error -> error
    end
  end

  defp validate_password(password, hashed_password) do
    if Argon2.verify_pass(password, hashed_password) do
      :ok
    else
      :error
    end
  end
end
