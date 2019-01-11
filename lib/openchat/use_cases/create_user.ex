defmodule OpenChat.UseCases.CreateUser do
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo
  alias OpenChat.Utils.IDGenerator

  def run(user_repo, username, password, about) do
    run(user_repo, username, password, about, IDGenerator.generate())
  end

  def run(user_repo, username, password, about, id) do
    if username_already_exists(user_repo, username) do
      {:error, "Username already taken"}
    else
      user = create_user_on_repo(user_repo, id, username, password, about)
      {:ok, user}
    end
  end

  defp username_already_exists(user_repo, username) do
    UserRepo.find_by_username(user_repo, username) != nil
  end

  defp create_user_on_repo(user_repo, id, username, password, about) do
    user = new_user(id, username, password, about)
    UserRepo.create(user_repo, user)
    user
  end

  defp new_user(id, username, password, about) do
    %User{
      id: id,
      username: username,
      password: password,
      about: about
    }
  end
end
