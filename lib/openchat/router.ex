defmodule OpenChat.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart, :json], json_decoder: Poison)

  plug(:match)
  plug(:dispatch)

  get("/", to: OpenChat.HelloWorldPlug)
  get("/status", do: send_resp(conn, 200, "OK"))

  post("/users", to: OpenChat.Controllers.CreateUserController)

  # POST /users { username, password, about }
  # 201 - { id, username, about }
  # 400 Username already in use.

  match(_, do: send_resp(conn, 404, "Not found!!"))
end
