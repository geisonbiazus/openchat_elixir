defmodule OpenChat.Repositories.UserRepo do
  defstruct data: %{}

  alias OpenChat.Repositories.UserRepo

  def new do
    %UserRepo{}
  end

  def find_by_id(repo, id) do
    repo.data[id]
  end

  def find_by_username(repo, username) do
    Enum.find(repo.data, fn {_, user} -> user.username == username end)
  end

  def create(repo, user) do
    %{repo | data: Map.put(repo.data, user.id, user)}
  end
end
