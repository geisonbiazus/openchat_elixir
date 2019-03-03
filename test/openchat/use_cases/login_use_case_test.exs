defmodule OpenChat.UseCases.LoginUseCaseTest do
  use ExUnit.Case, async: true

  alias OpenChat.Repositories.{UserRepo, UserRepoMemory}
  alias OpenChat.Entities.User
  alias OpenChat.UseCases.LoginUseCase

  @user %User{id: "id", username: "username", password: "password", about: "about"}

  describe "run" do
    setup do
      %{user_repo: UserRepoMemory.new()}
    end

    test "authenticates the user with valid credentials", %{user_repo: repo} do
      UserRepo.create(repo, @user)

      assert LoginUseCase.run(repo, @user.username, @user.password) == {:ok, @user}
    end

    test "validates user with invalid password", %{user_repo: repo} do
      UserRepo.create(repo, @user)

      assert LoginUseCase.run(repo, @user.username, "invalid password") ==
               {:error, "Invalid credentials."}
    end

    test "validates user with invalid username", %{user_repo: repo} do
      assert LoginUseCase.run(repo, "invalid username", @user.password) ==
               {:error, "Invalid credentials."}
    end
  end
end
