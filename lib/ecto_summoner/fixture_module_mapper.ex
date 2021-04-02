defmodule EctoSummoner.FixtureModuleMapper do
  use Agent

  alias EctoSummoner.FixtureAttributes

  #######
  # API #
  #######

  def map!(fixture_key) do
    fixture_key = to_string(fixture_key)

    Agent.get(__MODULE__, fn fixture_module_map ->
      [attrs] = Map.fetch!(fixture_module_map, fixture_key)
      attrs
    end)
  end

  def start_link(_) do
    config = Application.fetch_env!(:ecto_summoner, EctoSummoner.FixtureModuleMapper)

    app = Keyword.fetch!(config, :app)

    default_repo = Keyword.fetch!(config, :default_repo)

    ecto_schema_modules = find_app_ecto_schema_modules(app)

    underscored_basename_module_pairs =
      underscore_modules_basenames(ecto_schema_modules, default_repo)

    table_name_module_pairs =
      get_ecto_schema_modules_table_names(ecto_schema_modules, default_repo)

    fixture_keys_fixture_attr_values =
      underscored_basename_module_pairs ++ table_name_module_pairs

    base_fixture_module_map =
      Enum.reduce(fixture_keys_fixture_attr_values, %{}, fn {fixture_key, fixture_attrs}, acc ->
        all_fixture_attrs = [fixture_attrs | Map.get(acc, fixture_key, [])]
        Map.put(acc, fixture_key, all_fixture_attrs)
      end)

    Agent.start_link(fn -> base_fixture_module_map end, name: __MODULE__)
  end

  ################
  # Undocumented #
  ################

  @doc false
  def find_app_ecto_schema_modules(app) do
    app
    |> Application.spec(:modules)
    |> Enum.filter(fn module ->
      :exports
      |> module.module_info()
      |> Enum.find(&(&1 == {:__changeset__, 0}))
    end)
    |> Enum.filter(fn module ->
      :exports
      |> module.module_info()
      |> Enum.find(&(&1 == {:__struct__, 0}))
    end)
  end

  @doc false
  def get_ecto_schema_modules_table_names(ecto_schema_modules, repo) do
    Enum.map(ecto_schema_modules, fn module ->
      fixture_attrs =
        FixtureAttributes.Collection.new(derived_from: :schema_source, module: module, repo: repo)

      {module.__schema__(:source), fixture_attrs}
    end)
  end

  @doc false
  def underscore_modules_basenames(modules, repo) do
    modules
    |> Enum.map(fn module ->
      underscore_basename = underscore_module_basename(module)

      fixture_attrs =
        FixtureAttributes.Record.new(derived_from: :module_basename, module: module, repo: repo)

      {underscore_basename, fixture_attrs}
    end)
  end

  @doc false
  def underscore_module_basename(module) do
    module
    |> Module.split()
    |> List.last()
    |> Macro.underscore()
  end
end
