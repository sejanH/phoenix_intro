defmodule Discuss.TaxonomiesTest do
  use Discuss.DataCase

  alias Discuss.Taxonomies

  describe "taxonomies" do
    alias Discuss.Taxonomies.Taxonomy

    import Discuss.TaxonomiesFixtures

    @invalid_attrs %{name: nil, slug: nil, parent_id: nil, is_active: nil, post_count: nil, hierarchy_level: nil}

    test "list_taxonomies/0 returns all taxonomies" do
      taxonomy = taxonomy_fixture()
      assert Taxonomies.list_taxonomies() == [taxonomy]
    end

    test "get_taxonomy!/1 returns the taxonomy with given id" do
      taxonomy = taxonomy_fixture()
      assert Taxonomies.get_taxonomy!(taxonomy.id) == taxonomy
    end

    test "create_taxonomy/1 with valid data creates a taxonomy" do
      valid_attrs = %{name: "some name", slug: "some slug", parent_id: 42, is_active: true, post_count: 42, hierarchy_level: 42}

      assert {:ok, %Taxonomy{} = taxonomy} = Taxonomies.create_taxonomy(valid_attrs)
      assert taxonomy.name == "some name"
      assert taxonomy.slug == "some slug"
      assert taxonomy.parent_id == 42
      assert taxonomy.is_active == true
      assert taxonomy.post_count == 42
      assert taxonomy.hierarchy_level == 42
    end

    test "create_taxonomy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Taxonomies.create_taxonomy(@invalid_attrs)
    end

    test "update_taxonomy/2 with valid data updates the taxonomy" do
      taxonomy = taxonomy_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug", parent_id: 43, is_active: false, post_count: 43, hierarchy_level: 43}

      assert {:ok, %Taxonomy{} = taxonomy} = Taxonomies.update_taxonomy(taxonomy, update_attrs)
      assert taxonomy.name == "some updated name"
      assert taxonomy.slug == "some updated slug"
      assert taxonomy.parent_id == 43
      assert taxonomy.is_active == false
      assert taxonomy.post_count == 43
      assert taxonomy.hierarchy_level == 43
    end

    test "update_taxonomy/2 with invalid data returns error changeset" do
      taxonomy = taxonomy_fixture()
      assert {:error, %Ecto.Changeset{}} = Taxonomies.update_taxonomy(taxonomy, @invalid_attrs)
      assert taxonomy == Taxonomies.get_taxonomy!(taxonomy.id)
    end

    test "delete_taxonomy/1 deletes the taxonomy" do
      taxonomy = taxonomy_fixture()
      assert {:ok, %Taxonomy{}} = Taxonomies.delete_taxonomy(taxonomy)
      assert_raise Ecto.NoResultsError, fn -> Taxonomies.get_taxonomy!(taxonomy.id) end
    end

    test "change_taxonomy/1 returns a taxonomy changeset" do
      taxonomy = taxonomy_fixture()
      assert %Ecto.Changeset{} = Taxonomies.change_taxonomy(taxonomy)
    end
  end
end
