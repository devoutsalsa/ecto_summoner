defmodule EctoSummoner.Faker do
  #######
  # API #
  #######
  def fake!(ecto_schema_struct) do
    ecto_schema_struct
    |> get_queryable_non_autogenerate_fields()
    |> Enum.map(&fake_the_field!/1)
    |> Enum.into(%{})
  end

  ################
  # Undocumented #
  ################

  @doc false
  def get_queryable_non_autogenerate_fields(ecto_schema_struct) do
    ecto_schema_module = ecto_schema_struct.__struct__

    maybe_autogenerate_id = ecto_schema_module.__schema__(:autogenerate_id)

    maybe_associations =
      ecto_schema_module.__changeset__()
      |> Enum.filter(fn
        {_, {:assoc, _}} ->
          true

        _ ->
          false
      end)
      |> Enum.map(fn
        {_, {:assoc, %Ecto.Association.BelongsTo{} = val}} ->
          [val.owner_key]

        _ ->
          []
      end)
      |> List.flatten()

    maybe_autogenerate =
      :autogenerate
      |> ecto_schema_module.__schema__()
      |> Enum.map(fn {keys, _} -> keys end)
      |> List.flatten()

    keys_types_map = ecto_schema_module.__changeset__()

    keys_types_map = Map.take(keys_types_map, ecto_schema_module.__schema__(:query_fields))

    keys_types_map =
      if maybe_autogenerate_id,
        do: Map.delete(keys_types_map, elem(maybe_autogenerate_id, 0)),
        else: keys_types_map

    keys_types_map =
      if List.first(maybe_associations),
        do: Map.drop(keys_types_map, maybe_associations),
        else: keys_types_map

    keys_types_map =
      if List.first(maybe_autogenerate),
        do: Map.drop(keys_types_map, maybe_autogenerate),
        else: keys_types_map

    keys_types_map
  end

  def fake_the_field!({key, :integer}) do
    {key, PlusOneUpdoot.integer!()}
  end

  def fake_the_field!({key, :string}) do
    {key, PlusOneUpdoot.string!("#{key}-")}
  end
end
