defmodule OpenChat.Serializers.PostJSONSerializer do
  def serialize(post) do
    Poison.encode!(%{
      postId: post.id,
      userId: post.user_id,
      text: post.text,
      dateTime: post.date_time
    })
  end
end
