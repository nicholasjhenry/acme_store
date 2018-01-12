defmodule Result do
  def ok(term), do: {:ok, term}
  def error(term), do: {:error, term}
end
