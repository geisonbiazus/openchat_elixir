defmodule OpenChat.UseCases.CreatePostUseCaseTest do
  use ExUnit.Case, async: true

  alias OpenChat.UseCases.CreatePostUseCase
  alias OpenChat.Entities.Post
  alias OpenChat.Repositories.PostRepo

  @user_id "user_id"
  @post_id "post_id"
  @text "post text"
  @inappropriate_text "Text with inappropriate word"
  @date_time DateTime.from_naive!(~N[2019-01-26 13:26:08.003], "Etc/UTC")
  @post %Post{id: @post_id, text: @text, user_id: @user_id, date_time: @date_time}

  setup do
    {:ok, post_repo} = PostRepo.start_link()

    %{post_repo: post_repo}
  end

  describe "run" do
    test "creates a new post", %{post_repo: post_repo} do
      assert CreatePostUseCase.run(post_repo, @user_id, @text, @date_time, @post_id) ==
               {:ok, @post}
    end

    test "stores it in the repo", %{post_repo: post_repo} do
      {:ok, post} = CreatePostUseCase.run(post_repo, @user_id, @text)
      assert PostRepo.find_by_id(post_repo, post.id) == post
    end

    test "validates post with inappropriate language", %{post_repo: post_repo} do
      assert CreatePostUseCase.run(post_repo, @user_id, @inappropriate_text) ==
               {:error, "Post contains inappropriate language."}
    end
  end
end
