defmodule OpenChat.Controllers.LoginController do
  import Plug.Conn

  alias OpenChat.UseCases.LoginUseCase
  alias OpenChat.Serializers.UserJSONSerializer

  def init(options), do: options

  def call(conn, user_repo: user_repo) do
    %{
      "username" => username,
      "password" => password
    } = conn.params

    LoginUseCase.run(user_repo, username, password)
    |> respond(conn)
  end

  defp respond({:ok, user}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, user_json(user))
  end

  defp respond({:error, msg}, conn) do
    conn
    |> send_resp(404, msg)
  end

  defp user_json(user) do
    UserJSONSerializer.serialize(user)
  end
end
