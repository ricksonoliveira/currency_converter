# CurrencyConverter

Currency converter is a microservice dedicated to easily convert currencies given a value, using an external [API](https://exchangeratesapi.io/). 

* [Installation](https://github.com/ricksonoliveira/currency_converter#installation)
* [Tests](https://github.com/ricksonoliveira/currency_converter#tests)
* [API](https://github.com/ricksonoliveira/currency_converter#api)
* [Rotas](https://github.com/ricksonoliveira/currency_converter#endpoints)
  
  * [Create User](https://github.com/ricksonoliveira/currency_converter#create-user)
  * [Show User](https://github.com/ricksonoliveira/currency_converter#show-user)
  * [List Users](https://github.com/ricksonoliveira/currency_converter#list-users)
  * [Convert](https://github.com/ricksonoliveira/currency_converter#convert)
  * [List Conversions](https://github.com/ricksonoliveira/currency_converter#list-conversions)

## **Installation**

To use this service you'll need [Elixir](https://elixir-lang.org/install.html),
[Phoenix](https://hexdocs.pm/phoenix/installation.html) e [PostgreSql](https://www.postgresql.org/).

You may wanna use postgress from a docker container, for that, type the following command to create an up and running postgress container automatically for you `docker-compose -f postgres-compose.yml up -d`

* Install dependencies by using `mix deps.get`
* Setup your database structure by using `mix ecto.setup`
* Initialize Phoenix locally by typing `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser or api tool to access routes.

## **Tests**

* Run the tests using the command `mix test`

## **API**

To use this service, you might wanna first create you user with you name on it.

After successfully creating it, you'll want to copy you `user_id` to use it for currency conversions afterwards.

To convert you will have to provide you `user_id`, value to convert `value`, currency origin and destiny `currency_origin` `currency_denstiny`.

Check the endpoints below in which you can accomplish this.

## **Routes**

### **Create User**

endpoint: `/users/create`

type: `POST`

**Params**

* Name: `name string`

**Body Params (JSON)**

```json
{
 "user": {
  "name": "Rick"
 }
}
```

**Response**

```json
{
  "data": {
    "id": "259fd896-3d89-4765-9547-727f28bc8e19",
    "name": "Rick"
  }
}
```

### Show user

endpoint: `/users/show/{user_id}`

type: `GET`

**Reponse**

```json
{
  "data": {
    "id": "d45fdb57-744f-43c5-b342-25f5453573bb",
    "name": "Rick"
  }
}
```

### **List Users**

endpoint: `/users/list`

type: `GET`

**Response**

```json
"data": [
    {
      "id": "259fd896-3d89-4765-9547-727f28bc8e19",
      "name": "Rick"
    },
    {
      "id": "94f372b1-558e-426d-a23f-a6f3543783d1",
      "name": "Ana"
    }
  ]
```

### **Convert**

endpoint: `/currency/convert`

type: `POST`

**Params**

* Id of user created: `user_id string`

* Value: `value string|integer|decimal` *value does not matter because it's handled in the process.*,

* Currency in which you wish to convert from: `currency_origin`

* Currency in which you wish to have converted to: `currency_destiny`


Remember to use the id of the user created at endpoint `/users/create`.

**Body Params (JSON)**

```json
{
	"user_id": "d45fdb57-744f-43c5-b342-25f5453573bb",
	"value": "100",
	"currency_origin": "BRL",
	"currency_destiny": "EUR"
}
```

**Response**

```json
{
  "conversion_rate": 1.0,
  "currency_destiny": "EUR",
  "currency_origin": "BRL",
  "date": "2021-12-25T16:46:35",
  "message": "Converted Successfully!",
  "transaction_id": "763db094-1082-4b03-a6db-64b26060b6aa",
  "user_id": "d45fdb57-744f-43c5-b342-25f5453573bb",
  "value_converted": "643.5513000",
  "value_given": "100"
}
```

### **List Conversions**

endpoint: `/currency/list`

type: `GET`

**Response**

```json
{
  "data": [
    {
      "conversion_rate": 1.0,
      "currency_destiny": "EUR",
      "currency_origin": "BRL",
      "date": "2021-12-25T14:50:57",
      "transaction_id": "4383954d-b0e4-4690-93e1-0f9414e615b1",
      "value_converted": "643.5513000",
      "value_given": "100"
    },
    {
      "conversion_rate": 1.0,
      "currency_destiny": "EUR",
      "currency_origin": "BRL",
      "date": "2021-12-25T14:51:01",
      "transaction_id": "b20ceda1-cabf-47a7-962d-192d453050f8",
      "value_converted": "643.5513000",
      "value_given": "100"
    }
  ]
}
```
