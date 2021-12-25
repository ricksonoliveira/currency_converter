defmodule CurrencyConverter.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CurrencyConverter.Repo

  alias CurrencyConverter.Accounts.{User, UserCurrency}

  @doc """
    Returns the list of users.
  """
  def list_users do
    Repo.all(User)
  end

  @doc """
    Gets user by id.
  """
  def get(id), do: Repo.get(User, id)

  @doc """
    Gets single user.
  """
  def get_user!(id), do: Repo.get!(User, id)

  def list_user_currencies, do: Repo.all(UserCurrency)

  @doc """
    Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

   @doc """
    Create user currency on database.
  """
  def create_user_currency(attrs \\ %{}) do
    transaction = Ecto.Multi.new()
    |> Ecto.Multi.insert(:user_currency, insert_user_currency(attrs))
    |> Repo.transaction()

    case transaction do
      {:ok, operations} -> {:ok, operations.user_currency}
      {:error, :user_currency, changeset, _} -> {:error, changeset}
    end
  end

  def insert_user_currency(attrs) do
    %UserCurrency{}
    |> UserCurrency.changeset(attrs)
  end
end
