defmodule OpenChat.Controllers.CreatePostController do
  import Plug.Conn

  alias OpenChat.UseCases.CreatePostUseCase
  alias OpenChat.Serializers.PostJSONSerializer

  def init(options), do: options

  def call(conn, post_repo: post_repo) do
    %{
      "user_id" => user_id,
      "text" => text
    } = conn.params

    CreatePostUseCase.run(post_repo, user_id, text)
    |> respond(conn)
  end

  defp respond({:ok, post}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, post_json(post))
  end

  defp respond({:error, msg}, conn) do
    conn
    |> send_resp(400, msg)
  end

  defp post_json(post) do
    PostJSONSerializer.serialize(post)
  end
end
