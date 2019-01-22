defmodule OpenChat.Controllers.CreateUserController do
  import Plug.Conn

  alias OpenChat.UseCases.CreateUser

  def init(options), do: options

  def call(conn, user_repo: user_repo) do
    %{
      "username" => username,
      "password" => password,
      "about" => about
    } = conn.params

    CreateUser.run(user_repo, username, password, about)
    |> respond(conn)
  end

  defp respond({:ok, user}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, user_json(user))
  end

  defp respond({:error, msg}, conn) do
    conn
    |> send_resp(400, msg)
  end

  defp user_json(user) do
    Poison.encode!(%{id: user.id, username: user.username, about: user.about})
  end
end
