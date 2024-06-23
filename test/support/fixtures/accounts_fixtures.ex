defmodule Boutique.AccountFixtures do
  alias Boutique.Accounts

  @valid_attrs %{email: "email@example.com", password: "aS3cur3Password"}

  def account_fixture(attrs \\ %{}) do
    {:ok, account} = attrs
        |> Enum.into(@valid_attrs) 
        |> Accounts.register_account

    account
  end
end
