defmodule OpenChat.Serializers.UserJSONSerializer do
  def serialize(user) do
    Poison.encode!(%{id: user.id, username: user.username, about: user.about})
  end
end
