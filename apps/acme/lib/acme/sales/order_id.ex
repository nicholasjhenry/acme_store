defmodule Acme.Sales.OrderId do
  defstruct [:id]

  def generate do
    UUID.uuid1
  end

  def new!(id) do
    struct(__MODULE__, id: id)
  end

  def new(id) do
    __MODULE__
    |> struct(id: id)
    |> Result.ok
  end
end

