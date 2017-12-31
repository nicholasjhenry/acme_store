defmodule Acme.Sales.Order.State do
  use Acme.Schema
  alias Acme.Sales.{OrderInitiated, OrderPlaced}

  schema "sales_orders" do
    field :state, State.Ecto.Type

    timestamps()
  end

  def apply_events(state, events) do
    Enum.reduce(events, change(state), &apply_event(&2, &1))
  end

  defp apply_event(changeset, %OrderInitiated{order_id: order_id}) do
    changeset
    |> put_change(:id, order_id.id)
    |> put_change(:state, :initiated)
  end

  defp apply_event(changeset, %OrderPlaced{}) do
    changeset
    |> put_change(:state, :placed)
  end
end
