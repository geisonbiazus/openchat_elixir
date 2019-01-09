defmodule OpenChat.UseCases.CreateUser do
  alias OpenChat.Entities.User
  alias OpenChat.Repositories.UserRepo
  alias OpenChat.Utils.IDGenerator

  def run(user_repo, username, password, about) do
    run(user_repo, username, password, about, &IDGenerator.generate/0)
  end

  def run(user_repo, username, password, about, generate_id_fn) do
    user = %User{id: generate_id_fn.(), username: username, password: password, about: about}
    user_repo = UserRepo.create(user_repo, user)

    {user_repo, user}
  end
end
