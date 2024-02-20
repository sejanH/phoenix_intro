defmodule DiscussWeb.TaxonomyControllerTest do
  use DiscussWeb.ConnCase

  import Discuss.TaxonomiesFixtures

  alias Discuss.Taxonomies.Taxonomy

  @create_attrs %{
    name: "some name",
    slug: "some slug",
    parent_id: 42,
    is_active: true,
    post_count: 42,
    hierarchy_level: 42
  }
  @update_attrs %{
    name: "some updated name",
    slug: "some updated slug",
    parent_id: 43,
    is_active: false,
    post_count: 43,
    hierarchy_level: 43
  }
  @invalid_attrs %{name: nil, slug: nil, parent_id: nil, is_active: nil, post_count: nil, hierarchy_level: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all taxonomies", %{conn: conn} do
      conn = get(conn, ~p"/api/taxonomies")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create taxonomy" do
    test "renders taxonomy when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/taxonomies", taxonomy: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/taxonomies/#{id}")

      assert %{
               "id" => ^id,
               "hierarchy_level" => 42,
               "is_active" => true,
               "name" => "some name",
               "parent_id" => 42,
               "post_count" => 42,
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/taxonomies", taxonomy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update taxonomy" do
    setup [:create_taxonomy]

    test "renders taxonomy when data is valid", %{conn: conn, taxonomy: %Taxonomy{id: id} = taxonomy} do
      conn = put(conn, ~p"/api/taxonomies/#{taxonomy}", taxonomy: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/taxonomies/#{id}")

      assert %{
               "id" => ^id,
               "hierarchy_level" => 43,
               "is_active" => false,
               "name" => "some updated name",
               "parent_id" => 43,
               "post_count" => 43,
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, taxonomy: taxonomy} do
      conn = put(conn, ~p"/api/taxonomies/#{taxonomy}", taxonomy: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete taxonomy" do
    setup [:create_taxonomy]

    test "deletes chosen taxonomy", %{conn: conn, taxonomy: taxonomy} do
      conn = delete(conn, ~p"/api/taxonomies/#{taxonomy}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/taxonomies/#{taxonomy}")
      end
    end
  end

  defp create_taxonomy(_) do
    taxonomy = taxonomy_fixture()
    %{taxonomy: taxonomy}
  end
end
