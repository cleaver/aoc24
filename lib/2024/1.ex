import AOC

import InputHelpers

aoc 2024, 1 do
  def p1(input) do
    {list1, list2} =
      input
      |> parse_input()
      |> parse_lists()

    list_difference(Enum.sort(list1), Enum.sort(list2))
    |> Enum.sum()
  end

  defp parse_lists(input) do
    Enum.reduce(input, {[], []}, fn line, {acc1, acc2} ->
      [_, first, second] = Regex.run(~r/(\d+)\s+(\d+)/, line)
      {[String.to_integer(first) | acc1], [String.to_integer(second) | acc2]}
    end)
  end

  defp list_difference([a | rest1], [b | rest2]) do
    difference = abs(a - b)
    [difference | list_difference(rest1, rest2)]
  end

  defp list_difference([], []) do
    []
  end

  def p2(input) do
    {list1, list2} =
      input
      |> parse_input()
      |> parse_lists()

    hist_list_2 = Enum.frequencies(list2)

    list1
    |> Enum.map(&(&1 * Map.get(hist_list_2, &1, 0)))
    |> Enum.sum()
  end
end
