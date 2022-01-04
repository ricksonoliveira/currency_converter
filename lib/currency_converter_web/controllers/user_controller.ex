defmodule CurrencyConverterWeb.UserController do
  @moduledoc """
    Handles user actions
  """
  alias CurrencyConverter.Accounts
  use CurrencyConverterWeb, :controller

  @doc """
    Return list of all the users.
  """
  def list(conn, _) do
    conn
    |> render("list.json", users: Accounts.list_users)
  end

  @doc """
    Creates a new user
  """
  def create_user(conn, %{"user" => user}) do
    with {:ok, user} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> render("user_new.json", %{user: user})
    end
  end

  def show(conn, %{"user_id" => id}) do
    conn
    |> render("show.json", user: Accounts.get_user!(id))
  end
end
# API Request
# http://api.exchangeratesapi.io/latest?base=EUR&access_key=39f9cf6c14cdcdedc0b847cba55347df
