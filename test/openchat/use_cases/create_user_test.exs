defmodule OpenChat.UseCases.CreateUserTest do
  use ExUnit.Case

  alias OpenChat.UseCases.CreateUser
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo

  @id "id"
  @username "username"
  @password "password"
  @about "about"
  @user %User{id: @id, username: @username, password: @password, about: @about}

  setup do
    user_repo = UserRepo.new()
    %{user_repo: user_repo}
  end

  describe "when user doesn't exit" do
    test "creates a new user with the given arguments generating an id", %{user_repo: user_repo} do
      {:ok, _user_repo, user} = CreateUser.run(user_repo, @username, @password, @about, @id)
      assert user == @user
    end

    test "stores the created user in the given repo", %{user_repo: user_repo} do
      {:ok, user_repo, user} = CreateUser.run(user_repo, @username, @password, @about)

      assert UserRepo.find_by_id(user_repo, user.id) == user
    end
  end

  describe "when username is already taken" do
    test "returns and error", %{user_repo: user_repo} do
      user_repo = UserRepo.create(user_repo, @user)

      assert CreateUser.run(user_repo, @username, @password, @about) ==
               {:error, "Username already taken"}
    end
  end
end
