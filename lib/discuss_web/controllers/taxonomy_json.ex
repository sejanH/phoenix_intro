defmodule DiscussWeb.TaxonomyJSON do
  alias Discuss.Taxonomies.Taxonomy

  @doc """
  Renders a list of taxonomies.
  """
  def index(%{taxonomies: taxonomies}) do
    %{data: for(taxonomy <- taxonomies, do: data(taxonomy))}
  end

  @doc """
  Renders a single taxonomy.
  """
  def show(%{taxonomy: taxonomy}) do
    %{data: data(taxonomy)}
  end

  defp data(%Taxonomy{} = taxonomy) do
    %{
      id: taxonomy.id,
      name: taxonomy.name,
      slug: taxonomy.slug,
      parent_id: taxonomy.parent_id,
      is_active: taxonomy.is_active,
      post_count: taxonomy.post_count,
      hierarchy_level: taxonomy.hierarchy_level
    }
  end
end
