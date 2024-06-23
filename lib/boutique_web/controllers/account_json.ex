defmodule BoutiqueWeb.AccountJSON do
  def register(%{account: account}) do
    %{data: %{id: account.id, email: account.email}}
  end

  def login(%{account: account, token: token}) do
    %{
      data: %{
         account: %{id: account.id, email: account.email},
         token: token
      }
    }
  end
end
