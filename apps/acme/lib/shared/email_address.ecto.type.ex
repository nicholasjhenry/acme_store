defmodule EmailAddress.Ecto.Type do
  @behaviour Ecto.Type

  @impl Ecto.Type
  def type, do: :email_address

  @impl Ecto.Type
  def cast(val) do
    EmailAddress.new(val)
  end

  @impl Ecto.Type
  def load(val) do
    EmailAddress.new(val)
  end

  @impl Ecto.Type
  def dump(val) do
    {:ok, to_string(val)}
  end
end
