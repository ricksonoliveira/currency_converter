defmodule CurrencyConverterWeb.UserView do
@moduledoc """
  User view
"""
  use CurrencyConverterWeb, :view

  def render("list.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("user_new.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name
    }
  end
end
