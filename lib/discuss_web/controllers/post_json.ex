defmodule DiscussWeb.PostJSON do
  alias Discuss.Posts.Post

  @doc """
  Renders a list of posts.
  """
  def index(%{posts: posts}) do
    %{data: for(post <- posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  def data(%Post{} = post) do
    %{
      id: post.id,
      title: post.title,
      body: post.body,
      published: post.published,
      image: post.image
    }
  end
end
