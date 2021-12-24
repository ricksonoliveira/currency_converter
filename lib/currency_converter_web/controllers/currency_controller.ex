defmodule CurrencyConverterWeb.CurrencyController do
  @moduledoc """
    Handles currency actions
  """
  use CurrencyConverterWeb, :controller
  alias CurrencyConverter.Converter

  def convert(
    conn,
    %{
      "user_id" => user_id,
      "value" => value,
      "currency_origin" => currency_origin,
      "currency_destiny" => currency_destiny
    }
  ) do
    {:ok, data} = Converter.convert(
      user_id,
      value,
      currency_origin,
      currency_destiny
    )

    render(conn, "success.json", %{data: data, user_id: user_id})
  end
end
