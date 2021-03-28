defmodule EctoSummoner.FixtureModuleMapper do
  use Agent

  #######
  # API #
  #######

  def map!(fixture_key) when is_atom(fixture_key) do
    fixture_key = Atom.to_string(fixture_key)

    Agent.get(__MODULE__, fn fixture_module_map ->
      %{modules: [module], repo: repo} = Map.fetch!(fixture_module_map, fixture_key)
      %{module: module, repo: repo}
    end)
  end

  def start_link(_) do
    config = Application.fetch_env!(:ecto_summoner, EctoSummoner.FixtureModuleMapper)

    app = Keyword.fetch!(config, :app)

    default_repo = Keyword.fetch!(config, :default_repo)

    ecto_schema_modules = find_app_ecto_schema_modules(app)

    underscored_basename_module_pairs = underscore_modules_basenames(ecto_schema_modules)

    table_name_module_pairs = get_ecto_schema_modules_table_names(ecto_schema_modules)

    fixture_keys_module_values = underscored_basename_module_pairs ++ table_name_module_pairs

    base_fixture_module_map =
      Enum.reduce(fixture_keys_module_values, %{}, fn {fixture_key, module}, acc ->
        modules = [module | Map.get(acc, fixture_key, [])]

        val = %{
          modules: modules,
          repo: default_repo
        }

        Map.put(acc, fixture_key, val)
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
  def get_ecto_schema_modules_table_names(ecto_schema_modules) do
    Enum.map(ecto_schema_modules, &{&1.__schema__(:source), &1})
  end

  @doc false
  def underscore_modules_basenames(modules) do
    modules
    |> Enum.map(fn module ->
      underscore_basename =
        module
        |> Module.split()
        |> List.last()
        |> Macro.underscore()

      {underscore_basename, module}
    end)
  end
end
