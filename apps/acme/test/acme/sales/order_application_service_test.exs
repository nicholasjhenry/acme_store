defmodule Acme.Sales.OrderApplicationServiceTest do
  use Acme.DataCase

  alias Acme.Sales.{
    Order,
    OrderId,
    OrderRepository,
    OrderApplicationService,
    InitiateOrder,
    PlaceOrder
  }

  describe "when initiating an order" do
    test "then an order is initiated" do
      initiate_order_command = InitiateOrder.new(OrderId.generate)
      {:ok, initiated_order_id} = OrderApplicationService.handle(initiate_order_command)

      {:ok, initiated_order} = OrderRepository.order_of_id(OrderId.new(initiated_order_id))
      assert initiated_order
      assert Order.initiated?(initiated_order)
    end
  end

  describe "given an order initiated when placing an order" do
    setup :initiate_order

    test "then an order is placed", %{initiated_order: initiated_order} do
      place_order_command = PlaceOrder.new(initiated_order.id)
      {:ok, placed_order_id} = OrderApplicationService.handle(place_order_command)

      {:ok, placed_order} = OrderRepository.order_of_id(OrderId.new(placed_order_id))
      assert placed_order
      assert Order.placed?(placed_order)
    end
  end

  def initiate_order(_context) do
    initiated_order = insert(:sales_order, state: "initiated")

    [initiated_order: initiated_order]
  end
end
