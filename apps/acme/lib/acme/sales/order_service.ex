defmodule Acme.Sales.OrderService do
  alias Acme.Sales.{Order, InitiateOrder, OrderId, OrderRepository}

  def handle(%InitiateOrder{} = command) do
    with order_id = OrderId.new(command.order_id),
         {:ok, initiated_order} <- Order.initiate(order_id),
         {:ok, _persisted_order} <- OrderRepository.save(initiated_order),
      do: {:ok, command.order_id}
  end
end
