defmodule Boutique.Accounts.Crypto do
  @jws %{
    "alg" => "HS256"
  }

  def generate_token(%{} = claims) do
    with {:ok, jwk} <- get_jwk() do
      signed = JOSE.JWT.sign(jwk, @jws, claims)
      {_alg, token} = JOSE.JWS.compact(signed)
      {:ok, token}
    else
      error -> error
    end
  end

  def verify_token(token) do
    with {:ok, jwk} <- get_jwk(),
         {true, %JOSE.JWT{fields: claims}, _} <- JOSE.JWT.verify_strict(jwk, ["HS256"], token) do
      {:ok, claims}
    else
      {:error, :secret_not_configured} -> {:error, :secret_not_configured}
      _ -> {:error, :invalid_token}
    end
  end

  defp get_jwk() do
    case Application.fetch_env(:boutique, Boutique.Auth) do 
      {:ok, [{:secret, secret}]} ->
        jwk = %{
            "kty" => "oct",
            "k" => :jose_base64url.encode(secret)
        }

        {:ok, jwk}
      _ -> {:error, :secret_not_configured}
    end
  end
end
