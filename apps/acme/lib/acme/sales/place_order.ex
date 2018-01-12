defmodule Acme.Sales.PlaceOrder do
  use Ecto.Schema
  import Ecto.Changeset

  alias Acme.Sales.OrderId

  embedded_schema do
    field :order_id, OrderId.Ecto.Type
    field :email, EmailAddress.Ecto.Type
  end

  def new(id, email) do
    %__MODULE__{order_id: id, email: email}
  end

  def validate(unvalidated_command) do
    params = Map.from_struct(unvalidated_command)

    changeset =
      __MODULE__
      |> struct
      |> cast(params, []) # need it for changeset.cast
      |> cast_field(params, :order_id)
      |> cast_field(params, :email)

    determine_result(changeset)
  end

  defp determine_result(changeset) do
    if changeset.valid? do
      changeset |> apply_changes |> Result.ok
    else
      changeset |> Result.error
    end
  end

  defp cast_field(changeset, params, field) do
    type = get_type(changeset, field)
    changeset.params
    |> Map.get(Atom.to_string(field))
    |> type.new
    |> case do
      {:ok, value} -> put_change(changeset, field, value)
      {:error, message} -> add_error(changeset, field, message)
    end
  end

  defp get_type(changeset, field) do
    changeset.types[field]
    |> Atom.to_string
    |> String.replace(".Ecto.Type", "")
    |> String.to_atom
  end
end
