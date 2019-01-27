defmodule OpenChat.Entities.InappropriateLanguageValidator do
  def validate(text) do
    !String.contains?(text, "inappropriate")
  end
end
