import AOC
import InputHelpers

aoc 2024, 2 do
  @moduledoc """
  https://adventofcode.com/2024/day/2
  """

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    input
    |> parse_input()
    |> Enum.map(&split_to_integer_list/1)
    |> Enum.map(&safe?/1)
    |> Enum.count(& &1)
  end

  defp split_to_integer_list(line) do
    line
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end

  defp safe?(list, direction \\ :unknown)

  defp safe?([level1, level2 | rest], :unknown) do
    direction = if level1 > level2, do: :descending, else: :ascending
    safe_distance?(level1, level2) and safe?([level2 | rest], direction)
  end

  defp safe?([level1, level2 | rest], :ascending) do
    if level1 > level2,
      do: false,
      else: safe_distance?(level1, level2) and safe?([level2 | rest], :ascending)
  end

  defp safe?([level1, level2 | rest], :descending) do
    if level1 < level2,
      do: false,
      else: safe_distance?(level1, level2) and safe?([level2 | rest], :descending)
  end

  defp safe?([_], _), do: true

  defp safe_distance?(level1, level2) do
    distance = abs(level1 - level2)
    distance >= 1 and distance <= 3
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    input
    |> parse_input()
    |> Enum.map(&split_to_integer_list/1)
    # |> Enum.map(&damper_safe?/1)
    |> Enum.map(fn list ->
      damper_safe?(list)
    end)
  end

  defp damper_safe?(list, have_dropped \\ false, direction \\ :unknown)

  defp damper_safe?([_head | tail] = list, false, :unknown) do
    damper_safe?(list, false, :ascending) or
      damper_safe?(list, false, :descending) or
      damper_safe?(tail, true, :ascending) or
      damper_safe?(tail, true, :descending)
  end

  defp damper_safe?([level1, level2, level3 | rest], previously_dropped, direction) do
    {[new_level2, new_level3], newly_dropped} =
      drop_one([level1, level2, level3], previously_dropped, direction)

    maybe_drop_last(rest, newly_dropped) or
      (dbg(safe?([new_level2, new_level3], direction)) and
         damper_safe?([new_level2, new_level3 | rest], newly_dropped, direction))
  end

  defp damper_safe?([level1, level2], true, :ascending),
    do: level1 < level2

  defp damper_safe?([level1, level2], true, :descending),
    do: level1 > level2

  ## drop_one
  defp drop_one([_, level2, level3], true, _direction), do: {[level2, level3], true}

  defp drop_one([level1, level2, level3], false, direction) do
    is_monotonic = monotonic?([level1, level2, level3], direction)

    cond do
      is_monotonic and safe?([level1, level2], direction) ->
        {[level2, level3], false}

      safe?([level1, level3], direction) ->
        {[level1, level3], true}

      true ->
        {[level2, level3], false}
    end
  end

  # maybe_drop_last
  defp maybe_drop_last([] = _rest, false = _previously_dropped), do: true
  defp maybe_drop_last(_, _), do: false

  # monotonic?
  defp monotonic?([level1, level2, level3], :ascending), do: level1 < level2 and level2 < level3
  defp monotonic?([level1, level2, level3], :descending), do: level1 > level2 and level2 > level3
end
