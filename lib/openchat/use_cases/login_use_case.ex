defmodule OpenChat.UseCases.LoginUseCase do
  alias OpenChat.Repositories.UserRepo
  alias OpenChat.Entities.User

  def run(user_repo, username, password) do
    user = UserRepo.find_by_username(user_repo, username)

    if user && User.authenticate(user, password) do
      {:ok, user}
    else
      {:error, "Invalid credentials."}
    end
  end
end
