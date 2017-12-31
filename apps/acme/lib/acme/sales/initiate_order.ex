defmodule Acme.Sales.InitiateOrder do
  defstruct [:order_id]

  def new(id) do
    %__MODULE__{order_id: id}
  end
end
