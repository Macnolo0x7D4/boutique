defmodule Boutique.Accounts.SignIn do
  use Boutique, :use_case

  alias Boutique.Accounts

  def call(%{email: email, password: password}) do
    with {:ok, account} <- Accounts.get_account_by_email(email),
         :ok <- validate_password(password, account.hashed_password) do
      {:ok, account}
    else
      _ -> {:error, :invalid_credentials}
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
