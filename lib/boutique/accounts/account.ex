defmodule Boutique.Accounts.Account do
  use Boutique, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :email, :string
    field :hashed_password, :string, redact: true
    field :password, :string, virtual: true

    timestamps(type: :utc_datetime)
  end

  def registration_changeset(account, attrs, opts \\ []) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_email(opts)
    |> validate_password(opts)
    |> hash_password()
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

  def hash_password(changeset) do
    password = changeset |> get_change(:password)

    if password && changeset.valid? do
      hashed_password = Argon2.hash_pwd_salt(password)

      changeset
      |> put_change(:hashed_password, hashed_password)
      |> delete_change(:password)
    else
      changeset
    end
  end
end
