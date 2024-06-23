defmodule Boutique.Accounts do
  use Boutique, :context

  alias Boutique.Accounts.Account

  def get_account(id) do
    case Repo.get(Account, id) do
      nil -> {:error, :account_not_found}
      account -> {:ok, account}
    end
  end

  def get_account_by_email(email) when is_binary(email) do
    case Repo.get_by(Account, email: email) do
      nil -> {:error, :account_not_found}
      account -> {:ok, account}
    end
  end 

  def register_account(attrs) do
    %Account{}
    |> Account.registration_changeset(attrs)
    |> Repo.insert()
  end

  def sign_in(attrs) do
    Boutique.Accounts.SignIn.call(attrs)
  end
end
