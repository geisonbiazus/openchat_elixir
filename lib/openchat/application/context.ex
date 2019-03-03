defmodule OpenChat.Application.Context do
  def user_repo do
    OpenChat.Repositories.UserRepoMemory.new(OpenChat.Repositories.UserRepoMemory)
  end

  def post_repo do
    OpenChat.Repositories.PostRepoMemory.new(OpenChat.Repositories.PostRepoMemory)
  end
end
