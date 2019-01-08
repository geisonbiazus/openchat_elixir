defmodule OpenChat.Router do
  use Plug.Router

  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

  plug(:match)
  plug(:dispatch)

  get("/", to: OpenChat.HelloWorldPlug)
  get("/status", do: send_resp(conn, 200, "OK"))
  match(_, do: send_resp(conn, 404, "Not found!!"))
end
