defmodule CurrencyConverterWeb.CurrencyView do
  use CurrencyConverterWeb, :view

  def render("success.json", %{data: data, user_id: user_id}) do
    %{
      message: "Converted Successfully",
      transaction_id: data.transaction_id,
      user_id: user_id,
      currency_origin: data.currency_origin,
      currency_destiny: data.currency_destiny,
      value_given: data.value_given,
      value_converted: data.value_converted,
      conversion_rate: data.conversion_rate,
      date: data.inserted_at
    }
  end
end
