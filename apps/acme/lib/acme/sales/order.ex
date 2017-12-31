defmodule Acme.Sales.Order do
  defstruct [:pending_events, :current_state]

  alias Acme.Sales.OrderInitiated

  defmodule State do
    use Acme.Schema

    schema "sales_orders" do
      field :state, :string

      timestamps()
    end

    def apply_events(state, events) do
      Enum.reduce(events, change(state), &apply_event(&2, &1))
    end

    defp apply_event(changeset, %OrderInitiated{order_id: order_id}) do
      changeset
      |> put_change(:id, order_id.id)
      |> put_change(:state, "initiated")
    end
  end

  def new(current_state) do
    %__MODULE__{pending_events: [], current_state: current_state}
  end

  def initiate(order_id) do
    {:ok, %__MODULE__{pending_events: [%OrderInitiated{order_id: order_id}], current_state: %State{}}}
  end

  def initiated?(%{pending_events: [], current_state: %{state: state}}) do
    state == "initiated"
  end
end
