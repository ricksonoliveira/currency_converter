defmodule CurrencyConverter.ConverterTest do
  use CurrencyConverter.DataCase
  alias CurrencyConverter.Converter
  alias CurrencyConverter.Accounts.UserCurrency

  import CurrencyConverter.AccountsFixtures

  describe "converter" do
    @value "100"
    @currency_origin "USD"
    @currency_destiny "BRL"

    defp converter_fixture do
      Converter.convert(user_fixture().id, @value, @currency_origin, @currency_destiny)
    end

    test "convert/4 will convert correctly" do
      assert {:ok, _} = converter_fixture
    end

    test "convert/4 will return error when user does not exist" do
      user_id = "4383954d-b0e4-4690-93e1-0f9414e615b1"
      assert {:error, "User does not exists, please verify the given id!"}
        == Converter.convert(user_id, @value, @currency_origin, @currency_destiny)
    end

    test "convert/4 will return error when converting to same currency" do
      currency_destiny = "USD"
      assert {:error, "Cannot convert to the same currency given!"}
        == Converter.convert(user_fixture().id, @value, @currency_origin, currency_destiny)
    end

    test "get_rates/0 will return response from api" do
      {:ok, response} = Converter.get_rates
      assert response["base"] == "EUR"
      assert response["rates"]
    end

    test "perform_conversion/4 will perform logic of conversion" do
      {:ok, data} = Converter.perform_conversion(@value, @currency_origin, @currency_destiny)
      assert data.transaction_id
      assert data.conversion_rate
      assert data.value_converted
    end
  end
end
