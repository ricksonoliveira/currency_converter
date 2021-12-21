defmodule CurrencyConverter.Repo.Migrations.CreateUserCurrency do
  use Ecto.Migration

  def change do
    create table(:user_currency, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :currency_origin, :string
      add :currency_destiny, :string
      add :user_id, :integer
      add :conversion_rate, :float
      add :transaction_id, :string

      timestamps()
    end
  end
end
