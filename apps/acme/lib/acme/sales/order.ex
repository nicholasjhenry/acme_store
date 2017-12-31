defmodule Acme.Sales.Order do
  defstruct [:pending_events, :current_state]

  alias Acme.Sales.{OrderInitiated, OrderPlaced, Order}

  def new(current_state) do
    %__MODULE__{pending_events: [], current_state: current_state}
  end

  def initiate(order_id) do
    {:ok, %__MODULE__{pending_events: [%OrderInitiated{order_id: order_id}], current_state: %Order.State{}}}
  end

  def place(%{current_state: %{state: :initiated} = initiated_order}) do
    {:ok, %__MODULE__{pending_events: [%OrderPlaced{order_id: initiated_order.id}], current_state: initiated_order}}
  end

  def initiated?(%{pending_events: [], current_state: %{state: state}}) do
    state == :initiated
  end

  def placed?(%{pending_events: [], current_state: %{state: state}}) do
    state == :placed
  end
end
