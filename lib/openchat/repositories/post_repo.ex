defmodule OpenChat.Repositories.PostRepo do
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

  def create(repo, post) do
    Agent.update(repo, fn data ->
      Map.put(data, post.id, post)
    end)
  end
end
