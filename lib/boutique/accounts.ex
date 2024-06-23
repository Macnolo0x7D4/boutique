defmodule Boutique.Accounts do
  alias Boutique.Repo
  alias Boutique.Accounts.Account
  
  def register_account(attrs) do
    %Account{}
    |> Account.registration_changeset(attrs)
    |> Repo.insert()
  end
end
