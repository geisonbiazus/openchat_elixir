defmodule OpenChat.Controllers.CreateUserController do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{id: 1}))
  end
end
