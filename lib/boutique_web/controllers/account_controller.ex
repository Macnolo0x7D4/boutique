defmodule BoutiqueWeb.AccountController do
  use BoutiqueWeb, :controller

  alias Boutique.Accounts

  @spec register(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def register(conn, %{"account" => %{"email" => email, "password" => password}}) do
    case Accounts.register_account(%{email: email, password: password}) do
      {:ok, account} ->
        conn |> put_status(201) |> render(:register, account: account)
      {:error, _error} -> 
        conn |> put_status(400) |> json(%{ error: "invalid credentials" })
    end
  end

  def login(conn, %{"account" => %{"email" => email, "password" => password}}) do
    case Accounts.sign_in(%{email: email, password: password}) do
      {:ok, token, account} ->
        conn |> put_status(201) |> render(:login, account: account, token: token)
      {:error, _error} ->
        conn |> put_status(400) |> json(%{ error: "invalid Credentials" })
    end
  end
end
