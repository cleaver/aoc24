import AOC

aoc 2024, 8 do
  @moduledoc """
  https://adventofcode.com/2024/day/8
  """
  import InputHelpers
  import CombinationHelpers

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    antinodes = MapSet.new()

    parsed_input = parse_input(input)
    limit = length(parsed_input)

    parsed_input
    |> record_antennae()
    |> find_antinodes(antinodes, limit)
    |> MapSet.to_list()
    |> Enum.filter(fn {row, col} -> row >= 0 and col >= 0 and row < limit and col < limit end)
    |> Enum.count()
  end

  defp record_antennae(input) do
    input
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, row_num}, acc ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {char, col_num}, acc ->
        case char do
          "." ->
            acc

          frequency ->
            Map.update(acc, frequency, [{row_num, col_num}], &[{row_num, col_num} | &1])
        end
      end)
    end)
  end

  defp find_antinodes(antennae, antinodes, limit, resonant? \\ false) do
    Enum.reduce(antennae, antinodes, fn {_frequency, positions}, antinodes ->
      combine(positions, 2)
      |> Enum.filter(fn [pos1, pos2] -> pos1 != pos2 end)
      |> Enum.reduce(antinodes, fn [pos1, pos2], antinodes ->
        difference = subtract(pos2, pos1)
        antinodes_up = find_increasing(pos2, difference, limit, resonant?)
        antinodes_down = find_decreasing(pos1, difference, limit, resonant?)

        antinodes
        |> record_antinodes(antinodes_up)
        |> record_antinodes(antinodes_down)
      end)
    end)
  end

  defp find_increasing(start, difference, limit, resonant?) do
    find_next(start, difference, &add/2, limit, resonant?)
  end

  defp find_decreasing(start, difference, limit, resonant?) do
    find_next(start, difference, &subtract/2, limit, resonant?)
  end

  defp find_next(start, difference, operation, limit, true) do
    next_position = add(start, difference)

    if out_of_bounds?(next_position, limit) do
      []
    else
      [next_position | find_next(next_position, difference, operation, limit, true)]
    end
  end

  defp find_next(start, difference, operation, limit, false) do
    next_position = operation.(start, difference)

    if out_of_bounds?(next_position, limit) do
      []
    else
      [next_position]
    end
  end

  defp out_of_bounds?({row, col}, limit) do
    row < 0 or col < 0 or row >= limit or col >= limit
  end

  defp record_antinodes(map_set, antinode_list) do
    Enum.reduce(antinode_list, map_set, fn antinode, acc ->
      MapSet.put(acc, antinode)
    end)
  end

  defp subtract({row1, col1}, {row2, col2}), do: {row1 - row2, col1 - col2}
  defp add({row1, col1}, {row2, col2}), do: {row1 + row2, col1 + col2}

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    antinodes = MapSet.new()

    parsed_input = parse_input(input)
    limit = length(parsed_input)

    parsed_input
    |> record_antennae()
    |> find_antinodes(antinodes, limit, true)
    |> MapSet.to_list()
    |> Enum.filter(fn {row, col} -> row >= 0 and col >= 0 and row < limit and col < limit end)
    |> Enum.count()
  end
end
