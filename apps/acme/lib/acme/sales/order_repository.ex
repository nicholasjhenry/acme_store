defmodule Acme.Sales.OrderRepository do
  alias Acme.Sales.{Order, OrderId}

  def order_of_id(%OrderId{id: id}) do
    Order.State
    |> Acme.Repo.get(id)
    |> Order.new
    |> Result.ok
  end

  def save(order) do
    order.current_state
    |> Order.State.apply_events(order.pending_events)
    |> Acme.Repo.insert_or_update
  end
end
