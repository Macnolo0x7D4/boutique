defmodule BoutiqueWeb.AccountControllerTest do
  alias Boutique.AccountFixtures
  use BoutiqueWeb.ConnCase

  @valid_attrs %{
    email: "email@example.com",
    password: "Sup3r$ecUr3Passw0rd"
  }

  @invalid_attrs %{
    email: nil,
    password: nil
  }

  describe "register" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/register", account: @valid_attrs)
      assert %{"id" => _id} = json_response(conn, 201)["data"]
    end

    test "renders error when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/register", account: @invalid_attrs)
      assert json_response(conn, 400)
    end
  end

  describe "login" do
    test "renders account and token when data is valid", %{conn: conn} do
      AccountFixtures.account_fixture(@valid_attrs)

      conn = post(conn, ~p"/api/auth/login", account: @valid_attrs)
      assert %{"account" => account, "token" => token} = json_response(conn, 201)["data"]
      assert account["email"] == @valid_attrs.email
      assert String.starts_with?(token, "ey")
    end

    test "renders error when credentials are invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/login", account: @invalid_attrs)
      assert json_response(conn, 400)
    end

    test "renders error when account does not exists", %{conn: conn} do
      conn = post(conn, ~p"/api/auth/login", account: @valid_attrs)
      assert json_response(conn, 400)
    end
  end
end
