defmodule OpenChat.UseCases.CreateUserUseCaseTest do
  use ExUnit.Case, async: true

  alias OpenChat.UseCases.CreateUserUseCase
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo

  @id "id"
  @username "username"
  @password "password"
  @about "about"
  @user %User{id: @id, username: @username, password: @password, about: @about}

  setup do
    {:ok, user_repo} = UserRepo.start_link()
    %{user_repo: user_repo}
  end

  describe "when user doesn't exit" do
    test "creates a new user with the given arguments generating an id", %{user_repo: user_repo} do
      {:ok, user} = CreateUserUseCase.run(user_repo, @username, @password, @about, @id)
      assert user == @user
    end

    test "stores the created user in the given repo", %{user_repo: user_repo} do
      {:ok, user} = CreateUserUseCase.run(user_repo, @username, @password, @about)

      assert UserRepo.find_by_id(user_repo, user.id) == user
    end
  end

  describe "when username is already taken" do
    test "returns and error", %{user_repo: user_repo} do
      UserRepo.create(user_repo, @user)

      assert CreateUserUseCase.run(user_repo, @username, @password, @about) ==
               {:error, "Username already in use."}
    end
  end
end
