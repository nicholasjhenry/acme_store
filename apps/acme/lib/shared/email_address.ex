defmodule EmailAddress do
  def new(term) when is_binary(term) do
    {:ok, term}
  end
  def new(_term), do: {:error, "invalid email"}
end
