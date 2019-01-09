defmodule OpenChat.UseCases.CreateUserTest do
  use ExUnit.Case

  alias OpenChat.UseCases.CreateUser
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo

  @id "id"
  @username "username"
  @password "password"
  @about "about"

  test "creates a new user with the given arguments generating an id" do
    user_repo = UserRepo.new()

    {_user_repo, user} = CreateUser.run(user_repo, @username, @password, @about, @id)
    assert user == %User{id: @id, username: @username, password: @password, about: @about}
  end

  test "stores the created user in the given repo" do
    user_repo = UserRepo.new()
    {user_repo, user} = CreateUser.run(user_repo, @username, @password, @about)

    assert UserRepo.find_by_id(user_repo, user.id) == user
  end
end
