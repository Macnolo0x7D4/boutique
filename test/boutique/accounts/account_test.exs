defmodule Boutique.Accounts.AccountTest do
  use Boutique.DataCase

  alias Boutique.Accounts
  alias Boutique.Accounts.Account

  @valid_attrs %{email: "email@example.com", password: "aS3cur3Password"}
  @invalid_attrs %{email: nil, password: nil}

  describe "register account" do 
    @no_valid_email_attrs %{email: "as", password: "aS3cur3Password"}
    @no_valid_password_attrs %{email: "email@example.com", password: "example"}

    test "registrate_account/1 with valid data" do
      assert {:ok, %Account{} = account} = Accounts.register_account(@valid_attrs)
      assert account.email == @valid_attrs.email
      assert Argon2.verify_pass(@valid_attrs.password, account.hashed_password) 
    end

    test "registrate_account/1 with invalid data" do
      assert {:error, _error} = Accounts.register_account(@invalid_attrs)
    end

    test "registrate_account/1 with invalid email" do
      assert {:error, _error} = Accounts.register_account(@no_valid_email_attrs)
    end

    test "registrate_account/1 with invalid password" do
      assert {:error, _error} = Accounts.register_account(@no_valid_password_attrs)
    end
  end

  describe "sign in to account" do
    @no_existing_attrs %{email: "noemail@example.com", password: "Sup3r$3cUr3P4ssW0rd"}

    test "sign_in/1 with valid data" do
      assert {:ok, token} = Accounts.sign_in(@valid_attrs)
      assert account.email = @valid_attrs.email
    end

    test "sign_in/1 with invalid data" do
      assert {:error, _error} = Accounts.sign_in(@invalid_attrs)
    end

    test "sign_in/1 with no existing account" do
      assert {:error, _error} = Accounts.sign_in(@no_existing_attrs)
    end
  end
end

