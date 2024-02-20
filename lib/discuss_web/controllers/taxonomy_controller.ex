defmodule DiscussWeb.TaxonomyController do
  use DiscussWeb, :controller

  alias Discuss.Taxonomies
  alias Discuss.Taxonomies.Taxonomy

  action_fallback DiscussWeb.FallbackController

  def index(conn, _params) do
    taxonomies = Taxonomies.list_taxonomies()
    render(conn, :index, taxonomies: taxonomies)
  end

  def create(conn, %{"taxonomy" => taxonomy_params}) do
    with {:ok, %Taxonomy{} = taxonomy} <- Taxonomies.create_taxonomy(taxonomy_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/taxonomies/#{taxonomy}")
      |> render(:show, taxonomy: taxonomy)
    end
  end

  def show(conn, %{"id" => id}) do
    taxonomy = Taxonomies.get_taxonomy!(id)
    render(conn, :show, taxonomy: taxonomy)
  end

  def update(conn, %{"id" => id, "taxonomy" => taxonomy_params}) do
    taxonomy = Taxonomies.get_taxonomy!(id)

    with {:ok, %Taxonomy{} = taxonomy} <- Taxonomies.update_taxonomy(taxonomy, taxonomy_params) do
      render(conn, :show, taxonomy: taxonomy)
    end
  end

  def delete(conn, %{"id" => id}) do
    taxonomy = Taxonomies.get_taxonomy!(id)

    with {:ok, %Taxonomy{}} <- Taxonomies.delete_taxonomy(taxonomy) do
      send_resp(conn, :no_content, "")
    end
  end
end
