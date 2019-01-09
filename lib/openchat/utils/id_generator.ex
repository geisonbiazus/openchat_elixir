defmodule OpenChat.Utils.IDGenerator do
  def generate do
    UUID.uuid4()
  end
end
