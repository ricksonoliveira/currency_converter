defmodule CurrencyConverter.AccountsTest do
  use CurrencyConverter.DataCase

  alias CurrencyConverter.Accounts
  alias CurrencyConverter.Accounts.{User, UserCurrency}
  import CurrencyConverter.AccountsFixtures

  describe "users" do

    @invalid_attrs %{name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "get/1 gets single user with given id" do
      user = user_fixture()
      assert Accounts.get(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end

  describe "user_currency" do
    test "create_user_currency/1 with valid data creates user_currency" do
      valid_attrs = %{
        conversion_rate: 1.00,
        transaction_id: Ecto.UUID.generate(),
        value_given: Decimal.new(100),
        currency_origin: "USD",
        currency_destiny: "BRL",
        value_converted: Decimal.new(500),
      }

      assert {:ok, %UserCurrency{} = user_currency} = Accounts.create_user_currency(valid_attrs)
    end

    test "create_user_currency/1 with invalid data returns error" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_currency(%{transaction_id: nil})
    end
  end
end
