defmodule OpenChat.Controllers.CreatePostControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias OpenChat.Repositories.PostRepo
  alias OpenChat.Controllers.CreatePostController

  @user_id "user_id"
  @text "text"
  @inappropriate_text "inappropriate"
  @uuid_pattern ~r/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

  setup do
    {:ok, post_repo} = PostRepo.start_link()
    opts = CreatePostController.init(post_repo: post_repo)
    %{opts: opts}
  end

  describe "call" do
    test "creates a post and responds with its values", %{opts: opts} do
      conn = create_post(opts, @user_id, @text)

      %{
        "postId" => post_id,
        "userId" => user_id,
        "text" => text,
        "dateTime" => date_time
      } = Poison.decode!(conn.resp_body)

      assert Regex.match?(@uuid_pattern, post_id)
      assert user_id == @user_id
      assert text == @text
      assert date_time != nil
      assert conn.status == 201
    end

    test "reponds with the error message on invalid request", %{opts: opts} do
      conn = create_post(opts, @user_id, @inappropriate_text)
      assert conn.status == 400
      assert conn.resp_body == "Post contains inappropriate language."
    end
  end

  def create_post(opts, user_id, text) do
    params = %{user_id: user_id, text: text}

    conn(:post, "/users/" <> user_id <> "/timeline", params)
    |> CreatePostController.call(opts)
  end
end
