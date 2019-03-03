defmodule OpenChat.Application.Context do
  def user_repo do
    OpenChat.Repositories.UserRepo
  end

  def post_repo do
    OpenChat.Repositories.PostRepo
  end
end
