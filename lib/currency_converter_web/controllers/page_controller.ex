defmodule CurrencyConverterWeb.PageController do
  use CurrencyConverterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create_user(conn, %{"user" => user}) do

  end
end
# API Request
# http://api.exchangeratesapi.io/latest?base=EUR&access_key=39f9cf6c14cdcdedc0b847cba55347df
