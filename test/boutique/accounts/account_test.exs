defmodule Boutique.Accounts.AccountTest do
  use Boutique.DataCase

  alias Boutique.Accounts

  describe "accounts" do
    @valid_attrs %{email: 'email@example.com', password: 'aS3cur3Password'}

    test "registrate_account/1 with valid data" do
      assert {:ok, %Account{} == account} = Accounts.register_account(@valid_attrs)
      assert account.email == @valid_attrs.email
      assert Argon2.verify_pass(@valid_attrs.password, account.hashed_password) 
    end
  end
end

