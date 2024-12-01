import Config

config :advent_of_code_utils,
  session: System.get_env("ADVENT_SESSION"),
  auto_compile?: true,
  time_calls?: true,
  gen_tests?: true,
  year: 2024,
  day: 1

config :iex, inspect: [charlists: :as_lists]
