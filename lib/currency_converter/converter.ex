defmodule CurrencyConverter.Converter do
  @moduledoc """
    Reponsible for the convertions.
  """
  import Ecto.Query, warn: false

  alias CurrencyConverter.Repo
  alias CurrencyConverter.Accounts
  alias CurrencyConverter.Accounts.{User, UserCurrency}

  def convert(user_id, value, currency_origin, currency_destiny) do
    user = Accounts.get(user_id)
    validate_data(user, currency_origin, currency_destiny)
    perform_convertion(user, value, currency_origin, currency_destiny)
  end

  defp validate_data(user, currency_origin, currency_destiny) do
    case !user do
      true -> {:error, "User does not exists, please verify the given id!"}
      false -> case is_convert_to_same_currency?(currency_origin, currency_destiny) do
        true -> {:error, "Cannot convert to the same currency given!"}
        false -> {:ok}
      end
    end
  end

  defp is_convert_to_same_currency?(currency_origin, currency_destiny), do: currency_origin === currency_destiny


  def perform_convertion(user, value, currency_origin, currency_destiny) do
    {:ok, response} = get_rates()

    value_destiny = cond do
      currency_origin === "EUR" ->
        value_given_converted = Decimal.mult(value, Decimal.from_float(1.00))
        Decimal.mult(value_given_converted, Decimal.from_float(response["rates"][currency_origin]))
      currency_destiny === "EUR" ->
        value_given_converted = Decimal.mult(value, Decimal.from_float(response["rates"][currency_origin]))
        Decimal.mult(value_given_converted, Decimal.from_float(1.00))
      currency_origin != "EUR" and currency_destiny != "EUR" ->
        value_given_converted = Decimal.mult(value, Decimal.from_float(response["rates"][currency_origin]))
        Decimal.mult(value_given_converted, Decimal.from_float(response["rates"][currency_destiny]))
    end

    conversion_rate = cond do
      currency_origin === "EUR" ->
        1.00
      currency_origin != "EUR" ->
        response["rates"][currency_destiny]
    end

    create_user_currency(%{
      conversion_rate: conversion_rate,
      transaction_id: Ecto.UUID.generate(),
      value_given: Decimal.new(value),
      currency_origin: currency_origin,
      currency_destiny: currency_destiny,
      value_converted: value_destiny,
    })
  end

  def create_user_currency(attrs \\ %{}) do
    transaction = Ecto.Multi.new()
    |> Ecto.Multi.insert(:user_currency, create(attrs))
    |> Repo.transaction()

    case transaction do
      {:ok, operations} -> {:ok, operations.user_currency}
      {:error, :user_currency, changeset, _} -> {:error, changeset}
    end
  end

  def create(attrs) do
    %UserCurrency{}
    |> UserCurrency.changeset(attrs)
  end

  def get_rates do
    # Call to API
    url = "http://api.exchangeratesapi.io/latest?base=EUR&access_key=39f9cf6c14cdcdedc0b847cba55347df"

    {:ok, response} = HTTPoison.get(url)
    Jason.decode(response.body)
  end
end
