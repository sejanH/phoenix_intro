defmodule Discuss.TaxonomiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Taxonomies` context.
  """

  @doc """
  Generate a taxonomy.
  """
  def taxonomy_fixture(attrs \\ %{}) do
    {:ok, taxonomy} =
      attrs
      |> Enum.into(%{
        hierarchy_level: 42,
        is_active: true,
        name: "some name",
        parent_id: 42,
        post_count: 42,
        slug: "some slug"
      })
      |> Discuss.Taxonomies.create_taxonomy()

    taxonomy
  end
end
