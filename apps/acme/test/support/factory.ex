defmodule Acme.Factory do
  use ExMachina.Ecto, repo: Acme.Repo

  alias Acme.Sales

  def sales_order_factory do
    %Sales.Order.State{state: :initiated}
  end
end
