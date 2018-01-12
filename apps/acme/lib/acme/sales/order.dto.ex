defmodule Acme.Sales.Order.Dto do
  use Acme.Schema
  alias Acme.Sales.{OrderInitiated, OrderPlaced}

  schema "sales_orders" do
    field :state, State.Ecto.Type
    field :email, EmailAddress.Ecto.Type

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

  defp apply_event(changeset, %OrderPlaced{email: email}) do
    changeset
    |> put_change(:state, :placed)
    |> put_change(:email, email)
  end
end
