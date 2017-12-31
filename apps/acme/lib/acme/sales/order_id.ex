defmodule Acme.Sales.OrderId do
  defstruct [:id]

  def generate do
    UUID.uuid1
  end

  def new(id) do
    %__MODULE__{id: id}
  end
end

