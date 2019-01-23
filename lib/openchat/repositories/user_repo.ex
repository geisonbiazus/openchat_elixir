defmodule OpenChat.Repositories.UserRepo do
  use GenServer

  defstruct data: %{}

  def init(args) do
    {:ok, args}
  end

  def start_link(options \\ []) do
    Agent.start_link(fn -> %{} end, options)
  end

  def find_by_id(repo, id) do
    Agent.get(repo, & &1[id])
  end

  def find_by_username(repo, username) do
    Agent.get(repo, fn data ->
      Enum.find(data, fn {_, user} -> user.username == username end)
    end)
  end

  def create(repo, user) do
    Agent.update(repo, fn data ->
      Map.put(data, user.id, user)
    end)
  end
end
