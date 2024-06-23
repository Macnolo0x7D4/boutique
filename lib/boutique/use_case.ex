defmodule Boutique.UseCase do
  @callback call(args :: term) :: {:ok, any()} | {:error, any()}
end
