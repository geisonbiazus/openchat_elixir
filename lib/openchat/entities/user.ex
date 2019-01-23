defmodule OpenChat.Entities.User do
  defstruct id: "", username: "", password: "", about: ""

  def authenticate(user, password) do
    user.password == password
  end
end
