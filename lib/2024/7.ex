import AOC

aoc 2024, 7 do
  @moduledoc """
  https://adventofcode.com/2024/day/7
  """
  import InputHelpers

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    input
    |> parse_input()
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&valid_calibration?(&1, [:+, :*]))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end

  defp valid_calibration?({calibration, elements}, all_operators) do
    combine(all_operators, length(elements) - 1)
    |> Enum.any?(fn candidate_operators ->
      check_calculation(calibration, elements, candidate_operators)
    end)
  end

  defp check_calculation(calibration, elements, operators) do
    operators
    |> Enum.zip_reduce(tl(elements), hd(elements), fn op, term, acc ->
      case op do
        :+ -> acc + term
        :* -> acc * term
      end
    end)
    |> Kernel.==(calibration)
  end

  defp parse_line(line) do
    [calibration, right_side] = String.split(line, ":", trim: true)

    elements =
      right_side
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(calibration), elements}
  end

  defp combine(operators, count) do
    acc =
      for operator <- operators do
        [operator]
      end

    combine(operators, count - 1, acc)
  end

  defp combine(_, 0, acc), do: acc

  defp combine(operators, count, acc) do
    new_acc =
      for combination <- acc, operator <- operators do
        [operator | combination]
      end

    combine(operators, count - 1, new_acc)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    input
    |> parse_input()
    |> Enum.map(&parse_line/1)
    |> Enum.filter(&valid_calibration?(&1, [:+, :*, :||]))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
  end
end
