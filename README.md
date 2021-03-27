# EctoSummoner

Magically summon Ecto fixtures w/ fake data for your tests.

# Example


![Entity relationship diagram](http://www.plantuml.com/plantuml/png/RP31IiKm44Nt-OhG_Llu0Se35wwAuiPb6TknRo2PXiaDMiH_bnO2VQ6hG7BEdSozPf2XnE0Y9Vz2aPyNpKjW_-kyKcJ_-EGpJ7HsFfcCF8WE8olozY8AdjdSdzlzdhHyqOXYR5j0ar2nDpP9DpOAPv3tMDE9zSwpPB3nzFgjREVgfnXk4wtRPS4uG29dK4mrvOFCIB7kEWIXyPTfTy4_s9HZ8zr3vo-N_QWfxcxZ2lJTiKdNVlmSQqPLv51MCwolIDkCkx9E9OP_ "Entity relationship diagram")

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

