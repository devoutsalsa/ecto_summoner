defmodule EctoSummoner do
  @moduledoc """
  Documentation for `EctoSummoner`.
  """

  alias EctoSummoner.FixtureAttributes.Collection
  alias EctoSummoner.FixtureAttributes.Record
  alias EctoSummoner.FixtureModuleMapper
  alias EctoSummoner.Faker

  def summon!(fixture_key) do
    fixture_attributes = FixtureModuleMapper.map!(fixture_key)

    records = 
      case fixture_attributes do
        %Collection{count: count, module: module, repo: repo} -> 
          for _ <- 1..count do
            %Record{module: module, repo: repo}
          end
        record -> 
          [record]
      end

    records =
      for record <- records do
        belongs_tos = 
          record.module.__changeset__ 
          |> Enum.reduce([], fn 
            {key, {:assoc, %Ecto.Association.BelongsTo{}}}, acc -> 
              [key|acc]
             _, acc -> 
              acc 
          end)
          |> Enum.map(fn belongs_to -> 
            {belongs_to, summon!(belongs_to)}
          end)
          |> Enum.map(fn {key, belongs_to} -> 
            {key, belongs_to} 
          end)
          |> Enum.into(%{}) 

        attrs = 
          record.module.__struct__
          |> Faker.fake!()
          |> Map.merge(belongs_tos) 
          |> strip_struct_meta()

        record.module.__struct__
        |> record.module.changeset(attrs)
        |> record.repo.insert!()
      end

    case fixture_attributes do
      %Collection{} -> 
        records
       _ -> 
        [record] = records
        record
    end
  end

  def strip_struct_meta(%{__struct__: _, __meta__: _} = struct) do
    struct
    |> Map.delete(:__struct__)
    |> Map.delete(:__meta__)
    |> Enum.reject(fn {_, val} -> 
      match?(%Ecto.Association.NotLoaded{}, val)
    end)
    |> Enum.into(%{})
    |> strip_struct_meta()
  end

  def strip_struct_meta(%{__struct__: _} = struct) do
    struct
  end

  def strip_struct_meta(%{} = map) do
    map
    |> Enum.map(fn {key, val} -> 
      {key, strip_struct_meta(val)}
    end)
    |> Enum.into(%{})
  end

  def strip_struct_meta(list) when is_list(list) do
    Enum.map(list, &strip_struct_meta/1)
  end

  def strip_struct_meta(arg) do
    arg 
  end
end


