defmodule OpenChat.UseCases.CreateUser do
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo
  alias OpenChat.Utils.IDGenerator

  def run(user_repo, username, password, about) do
    run(user_repo, username, password, about, IDGenerator.generate())
  end

  def run(user_repo, username, password, about, id) do
    user = new_user(id, username, password, about)
    user_repo = UserRepo.create(user_repo, user)

    {user_repo, user}
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
