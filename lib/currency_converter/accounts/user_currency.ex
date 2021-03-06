defmodule CurrencyConverter.Accounts.UserCurrency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "user_currency" do
    field :conversion_rate, :float
    field :currency_destiny, :string
    field :currency_origin, :string
    field :transaction_id, :string
    field :value_converted, :decimal
    field :value_given, :decimal

    timestamps()
  end

  @doc false
  def changeset(user_currency, attrs) do
    user_currency
    |> cast(attrs, [:currency_origin, :currency_destiny, :conversion_rate, :transaction_id, :value_given, :value_converted])
    |> validate_required([:currency_origin, :currency_destiny, :conversion_rate, :transaction_id, :value_given, :value_converted])
  end
end
