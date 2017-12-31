defmodule Acme.Sales.OrderApplicationService do
  alias Acme.Sales.{Order, OrderId, OrderRepository, InitiateOrder, PlaceOrder}

  def handle(%InitiateOrder{} = command) do
    with order_id = OrderId.new(command.order_id),
         {:ok, initiated_order} <- Order.initiate(order_id),
         {:ok, _persisted_order} <- OrderRepository.save(initiated_order),
      do: {:ok, command.order_id}
  end

  def handle(%PlaceOrder{} = command) do
    with order_id = OrderId.new(command.order_id),
         {:ok, initiated_order} = OrderRepository.order_of_id(order_id),
         {:ok, placed_order} <- Order.place(initiated_order),
         {:ok, _persisted_order} <- OrderRepository.save(placed_order),
      do: {:ok, command.order_id}
  end
end
