defmodule Discuss.Taxonomies do
  @moduledoc """
  The Taxonomies context.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Taxonomies.Taxonomy

  @doc """
  Returns the list of taxonomies.

  ## Examples

      iex> list_taxonomies()
      [%Taxonomy{}, ...]

  """
  def list_taxonomies do
    Repo.all(Taxonomy)
  end

  @doc """
  Gets a single taxonomy.

  Raises `Ecto.NoResultsError` if the Taxonomy does not exist.

  ## Examples

      iex> get_taxonomy!(123)
      %Taxonomy{}

      iex> get_taxonomy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_taxonomy!(id), do: Repo.get!(Taxonomy, id)

  @doc """
  Creates a taxonomy.

  ## Examples

      iex> create_taxonomy(%{field: value})
      {:ok, %Taxonomy{}}

      iex> create_taxonomy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_taxonomy(attrs \\ %{}) do
    %Taxonomy{}
    |> Taxonomy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a taxonomy.

  ## Examples

      iex> update_taxonomy(taxonomy, %{field: new_value})
      {:ok, %Taxonomy{}}

      iex> update_taxonomy(taxonomy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_taxonomy(%Taxonomy{} = taxonomy, attrs) do
    taxonomy
    |> Taxonomy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a taxonomy.

  ## Examples

      iex> delete_taxonomy(taxonomy)
      {:ok, %Taxonomy{}}

      iex> delete_taxonomy(taxonomy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_taxonomy(%Taxonomy{} = taxonomy) do
    Repo.delete(taxonomy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking taxonomy changes.

  ## Examples

      iex> change_taxonomy(taxonomy)
      %Ecto.Changeset{data: %Taxonomy{}}

  """
  def change_taxonomy(%Taxonomy{} = taxonomy, attrs \\ %{}) do
    Taxonomy.changeset(taxonomy, attrs)
  end
end
