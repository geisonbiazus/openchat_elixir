defprotocol OpenChat.Repositories.UserRepo do
  def find_by_id(repo, id)
  def find_by_username(repo, username)
  def create(repo, user)
end
