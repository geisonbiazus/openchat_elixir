defmodule OpenChat.Repositories.PostRepoMemory do
  use Agent

  defstruct [:pid]

  def new do
    {:ok, pid} = start_link()
    new(pid)
  end

  def new(pid) do
    %OpenChat.Repositories.PostRepoMemory{pid: pid}
  end

  def start_link(options \\ []) do
    Agent.start_link(fn -> %{} end, options)
  end

  def find_by_id(%{pid: pid}, id) do
    Agent.get(pid, & &1[id])
  end

  def create(%{pid: pid}, post) do
    Agent.update(pid, fn data ->
      Map.put(data, post.id, post)
    end)
  end
end

alias OpenChat.Repositories.{PostRepo, PostRepoMemory}

defimpl PostRepo, for: PostRepoMemory do
  def find_by_id(repo, id), do: PostRepoMemory.find_by_id(repo, id)
  def create(repo, post), do: PostRepoMemory.create(repo, post)
end
