defmodule Boutique.Accounts.Account do
  use Boutique, :model

  schema "accounts" do
    field :email, :string
    field :hashed_password, :string, redact: true
    field :password, :string, virtual: true
  end

  def registration_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_password(opts)
  end

  def validate_email(changeset, _opts) do
    changeset
    |> validate_required(:email)
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 100)
  end

  def validate_password(changeset, _opts) do
    changeset
    |> validate_required(:password)
    |> validate_length(:password, min: 8, max: 64)
  end
end
