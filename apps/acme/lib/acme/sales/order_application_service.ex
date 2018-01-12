defmodule Acme.Sales.OrderApplicationService do
  alias Acme.Sales.{Order, OrderId, OrderRepository, InitiateOrder, PlaceOrder}

  def handle(%InitiateOrder{} = unvalidated_command) do
    with {:ok, valid_command} = InitiateOrder.validate(unvalidated_command),
         {:ok, initiated_order} <- Order.initiate(valid_command.order_id),
         {:ok, _persisted_order} <- OrderRepository.save(initiated_order),
      do: {:ok, valid_command.order_id}
  end

  def handle(%PlaceOrder{} = unvalidated_command) do
    with {:ok, valid_command} = PlaceOrder.validate(unvalidated_command),
         {:ok, initiated_order} = OrderRepository.order_of_id(valid_command.order_id),
         {:ok, placed_order} <- Order.place(initiated_order, %{email: valid_command.email}),
         {:ok, _persisted_order} <- OrderRepository.save(placed_order),
      do: {:ok, valid_command.order_id}
  end
end
