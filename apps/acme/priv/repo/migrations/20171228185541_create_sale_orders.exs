defmodule Acme.Repo.Migrations.CreateSaleOrders do
  use Ecto.Migration

  def change do
    create table(:sales_orders) do
      add :state, :string, null: false, default: "pending"
      add :email, :string

      timestamps
    end
  end
end
