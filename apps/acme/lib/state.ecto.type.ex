defmodule State.Ecto.Type do
  def type, do: :order_number

  def cast(term) do
    {:ok, String.to_atom(term)}
  end

  def load(term) do
    {:ok, String.to_atom(term)}
  end

  def dump(term) do
    {:ok, Atom.to_string(term)}
  end
end
