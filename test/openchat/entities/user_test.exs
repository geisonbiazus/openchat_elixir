defmodule OpenChat.Entities.UserTest do
  use ExUnit.Case, async: true

  alias OpenChat.Entities.User

  describe "authenticate" do
    test "checks if a password is valid for the given user" do
      user = %User{username: "name", password: "password"}
      assert User.authenticate(user, "password")
      refute User.authenticate(user, "wrong password")
    end
  end
end
