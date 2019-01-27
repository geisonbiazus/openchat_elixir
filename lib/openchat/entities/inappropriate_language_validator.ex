defmodule OpenChat.Entities.InappropriateLanguageValidator do
  @blacklist ~r/orange|ice cream|elephant/i

  def validate(text) do
    !Regex.match?(@blacklist, text)
  end
end
