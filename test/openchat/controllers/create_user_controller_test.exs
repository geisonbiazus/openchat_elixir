defmodule OpenChat.Controllers.CreateUserControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias OpenChat.Controllers.CreateUserController
  alias OpenChat.Repositories.UserRepoMemory

  @username "username"
  @password "password"
  @about "about"
  @uuid_pattern ~r/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/

  setup do
    opts = CreateUserController.init(user_repo: UserRepoMemory.new())
    %{opts: opts}
  end

  describe "with valid parameters" do
    test "it creates a user and responds with its values", %{opts: opts} do
      conn = create_user(opts, @username, @password, @about)

      %{
        "id" => id,
        "username" => username,
        "about" => about
      } = Poison.decode!(conn.resp_body)

      assert username == @username
      assert about == @about
      assert Regex.match?(@uuid_pattern, id)

      assert conn.status == 201
    end
  end

  describe "when username has already been taken" do
    test "it responds with error", %{opts: opts} do
      create_user(opts, @username, @password, @about)
      conn = create_user(opts, @username, @password, @about)

      assert conn.status == 400
      assert conn.resp_body == "Username already in use."
    end
  end

  def create_user(opts, username, password, about) do
    params = %{username: username, password: password, about: about}

    conn(:post, "/users", params)
    |> CreateUserController.call(opts)
  end
end
