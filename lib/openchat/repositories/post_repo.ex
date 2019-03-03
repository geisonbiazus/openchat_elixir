defprotocol OpenChat.Repositories.PostRepo do
  def find_by_id(repo, id)
  def create(repo, post)
end
