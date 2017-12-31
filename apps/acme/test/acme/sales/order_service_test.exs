defmodule Acme.Sales.OrderServiceTest do
  use Acme.DataCase

  alias Acme.Sales.{Order, OrderId, OrderRepository, OrderService, InitiateOrder}

  describe "when initiating an order" do
    test "then an order is initiated" do
      initiate_order_command = InitiateOrder.new(OrderId.generate)
      {:ok, initiated_order_id} = OrderService.handle(initiate_order_command)

      initiated_order = OrderRepository.order_of_id(OrderId.new(initiated_order_id))
      assert initiated_order
      assert Order.initiated?(initiated_order)
    end
  end
end
