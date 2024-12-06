import AOC

aoc 2024, 3 do
  @moduledoc """
  https://adventofcode.com/2024/day/3
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    input
    |> parse_muls()
    |> Enum.map(&execute_mul/1)
    |> Enum.sum()
  end

  defp parse_muls(input) do
    Regex.scan(~r/mul\(\d+,\d+\)/, input)
    |> List.flatten()
  end

  defp execute_mul(mul) do
    [a, b] =
      Regex.scan(~r/\d+/, mul)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

    a * b
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    input
    |> parse_commands()
    |> execute_commands()
    |> elem(1)
    |> Enum.sum()
  end

  defp parse_commands(input) do
    Regex.scan(~r/(mul\(\d+,\d+\)|do\(\)|don't\(\))/, input, capture: :first)
    |> List.flatten()
  end

  defp execute_commands(commands) do
    commands
    |> Enum.reduce({:run, []}, &execute_single_command/2)
  end

  defp execute_single_command("do()", {_run_state, acc}), do: {:run, acc}
  defp execute_single_command("don't()", {_run_state, acc}), do: {:stop, acc}
  defp execute_single_command(mul, {:run, acc}), do: {:run, [execute_mul(mul) | acc]}
  defp execute_single_command(_, state), do: state
end
