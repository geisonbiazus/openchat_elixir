defmodule OpenChat.Repositories.UserRepoMemory do
  use Agent

  defstruct [:pid]

  def new do
    {:ok, pid} = start_link()
    new(pid)
  end

  def new(pid) do
    %OpenChat.Repositories.UserRepoMemory{pid: pid}
  end

  def start_link(options \\ []) do
    Agent.start_link(fn -> %{} end, options)
  end

  def find_by_id(%{pid: pid}, id) do
    Agent.get(pid, & &1[id])
  end

  def find_by_username(%{pid: pid}, username) do
    Agent.get(pid, fn data ->
      case Enum.find(data, fn {_, user} -> user.username == username end) do
        {_, user} -> user
        _ -> nil
      end
    end)
  end

  def create(%{pid: pid}, user) do
    Agent.update(pid, fn data ->
      Map.put(data, user.id, user)
    end)
  end
end

alias OpenChat.Repositories.{UserRepo, UserRepoMemory}

defimpl UserRepo, for: UserRepoMemory do
  def find_by_id(repo, id), do: UserRepoMemory.find_by_id(repo, id)

  def find_by_username(repo, username) do
    UserRepoMemory.find_by_username(repo, username)
  end

  def create(repo, user), do: UserRepoMemory.create(repo, user)
end
