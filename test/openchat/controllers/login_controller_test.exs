defmodule OpenChat.Controllers.LoginControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias OpenChat.Controllers.LoginController
  alias OpenChat.Repositories.UserRepo
  alias OpenChat.Entities.User

  @user %User{id: "id", username: "username", password: "password", about: "about"}

  setup do
    {:ok, user_repo} = UserRepo.start_link()
    opts = LoginController.init(user_repo: user_repo)

    UserRepo.create(user_repo, @user)

    %{opts: opts}
  end

  describe "run" do
    test "authenticate valid credentials", %{opts: opts} do
      conn = login(opts, @user.username, @user.password)

      assert conn.status == 200

      assert Poison.decode!(conn.resp_body) == %{
               "id" => @user.id,
               "username" => @user.username,
               "about" => @user.about
             }
    end

    test "responds invalid credentials", %{opts: opts} do
      conn = login(opts, @user.username, "invalid password")

      assert conn.status == 404
      assert conn.resp_body == "Invalid credentials."
    end
  end

  def login(opts, username, password) do
    params = %{username: username, password: password}

    conn(:post, "/login", params)
    |> LoginController.call(opts)
  end
end
