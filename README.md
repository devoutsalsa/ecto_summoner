# EctoSummoner

Magically summon Ecto fixtures w/ fake data for your tests.

![Entity relationship diagram](http://www.plantuml.com/plantuml/png/RP31IiGm48RlUOgXzptu0Cg21oyMnOl7ChPZTo2PXCa4BUAxImfXrz1J8FDz_oJ_EHkgbU1Tm0HF6EWnIewUuCU1O22uVu1ioh8wICepJIpJJ6AvJbYCLbBtwtR_EQxL0n_NgzU68qhvnDcAabQgnNVOAocd2odw8mZ0jdHWlT7AsKXfUVaIqcFrWzKk2sxrijWy6GVAXY6rb7TKHR5jrutDTtvSTjVeswfoMzTmDy3fj1yjnVtxSGF60Muyrp_y6EjNDUHQLhTiR4ZVZ3kJB2NuFm00 "Entity relationship diagram")

# Example For Single Record

```
iex> summon!(:log)
%Log{log: "log_0"}
```

# Example With Associations


**Relationships:**

* GameConsole <- one to one -> Warranty
* GameConsole <- one to many -> Peripheral
* RegisteredOwner <- one to many -> GameConsole
* Manufacturer <- one to many ->  GameConsoles
* Manufacturer <- many to many -> RegisteredOwner

**Command**

```
# This one command generates:
# - 1 GameConsole
# - 2+ Peripherals for the GameConsole
# - 1 Warranty for the GameConsole
# - 1 RegisteredOwner for the GameConsole
# - 1 Manufacturer for the GameConsole,
#   2+ RegisteredOwners for the Manufacturer,
#   2+ Manufacturers for each Registered Owner,
#   and 1 GameConsole for each Manufacturer
summon!(
  game_console: [
    :peripherals, 
    :warranty, 
    :registered_owner, 
    manufacturer: [
      registered_owners: [
        manufacturers: :game_console
      ]
    ]
  ]
)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ecto_summoner` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ecto_summoner, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_summoner](https://hexdocs.pm/ecto_summoner).

