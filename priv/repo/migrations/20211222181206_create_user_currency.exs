defmodule CurrencyConverter.Repo.Migrations.CreateUserCurrency do
  use Ecto.Migration

  def change do
    create table(:user_currency, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :conversion_rate, :float
      add :currency_destiny, :string
      add :currency_origin, :string
      add :transaction_id, :string
      add :value_converted, :decimal
      add :value_given, :decimal

      timestamps()
    end
  end
end
