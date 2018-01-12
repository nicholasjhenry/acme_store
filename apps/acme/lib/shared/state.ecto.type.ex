defmodule State.Ecto.Type do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def type, do: :state

  @impl Ecto.Type
  def cast(term) do
    {:ok, String.to_atom(term)}
  end

  @impl Ecto.Type
  def load(term) do
    {:ok, String.to_atom(term)}
  end

  @impl Ecto.Type
  def dump(term) do
    {:ok, Atom.to_string(term)}
  end
end
