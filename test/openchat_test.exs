defmodule OpenChatTest do
  use ExUnit.Case
  doctest OpenChat

  test "greets the world" do
    assert OpenChat.hello() == :world
  end
end
