defmodule Acme.Sales.OrderId.Ecto.Type do
  @behaviour Ecto.Type

  alias Acme.Sales.OrderId

  @impl Ecto.Type
  def type, do: :order_id

  @impl Ecto.Type
  def cast(val) do
    OrderId.new(val)
  end

  @impl Ecto.Type
  def load(val) do
    OrderId.new(val)
  end

  @impl Ecto.Type
  def dump(val) do
    {:ok, to_string(val)}
  end
end
