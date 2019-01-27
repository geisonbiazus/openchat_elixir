defmodule OpenChat.UseCases.CreatePostUseCase do
  alias OpenChat.Entities.Post
  alias OpenChat.Entities.InappropriateLanguageValidator
  alias OpenChat.Utils.IDGenerator
  alias OpenChat.Repositories.PostRepo

  def run(
        post_repo,
        user_id,
        text,
        date_time \\ now(),
        post_id \\ IDGenerator.generate()
      ) do
    if InappropriateLanguageValidator.validate(text) do
      post = %Post{id: post_id, user_id: user_id, text: text, date_time: date_time}
      PostRepo.create(post_repo, post)
      {:ok, post}
    else
      {:error, "Post contains inappropriate language."}
    end
  end

  defp now do
    {:ok, now} = DateTime.now("Etc/UTC")
    now
  end
end
