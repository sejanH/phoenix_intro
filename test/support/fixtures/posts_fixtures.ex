defmodule Discuss.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        image: "some image",
        published: true,
        title: "some title"
      })
      |> Discuss.Posts.create_post()

    post
  end
end
