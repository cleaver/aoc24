import AOC

aoc 2024, 6 do
  @moduledoc """
  https://adventofcode.com/2024/day/6
  """

  import InputHelpers
  import MapHelpers

  @visited_mapset :visited

  @next_direction %{{0, 1} => {1, 0}, {1, 0} => {0, -1}, {0, -1} => {-1, 0}, {-1, 0} => {0, 1}}

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    MapSetAgent.start(@visited_mapset)

    parsed_input =
      input
      |> parse_input()

    start_position = find_start(parsed_input)
    MapSetAgent.put(start_position, @visited_mapset)

    {grid, _, _} =
      parsed_input
      |> mapify()

    walk_grid(grid, start_position)

    visited_count =
      MapSetAgent.dump(@visited_mapset)
      |> MapSet.size()

    MapSetAgent.stop(@visited_mapset)
    visited_count
  end

  defp walk_grid(grid, position, direction \\ {-1, 0}) do
    next_position = add_position(position, direction)

    case check_position(grid, next_position, direction) do
      :out_of_bounds ->
        next_position

      :blocked ->
        walk_grid(grid, position, @next_direction[direction])

      :empty ->
        MapSetAgent.put(next_position, @visited_mapset)
        walk_grid(grid, next_position, direction)
    end
  end

  defp add_position({row, col}, {row_offset, col_offset}),
    do: {row + row_offset, col + col_offset}

  defp check_position(grid, position, direction) do
    case grid[position] do
      nil -> :out_of_bounds
      "#" -> :blocked
      _ -> :empty
    end
  end

  defp find_start(lines) do
    lines
    |> Enum.with_index()
    |> Enum.reduce_while(nil, fn {line, row_index}, _acc ->
      case Regex.run(~r/\^/, line, return: :index) do
        [{col_index, _}] -> {:halt, {row_index, col_index}}
        _ -> {:cont, nil}
      end
    end)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    MapSetAgent.start(@visited_mapset)

    parsed_input =
      input
      |> parse_input()

    start_position = find_start(parsed_input)
    MapSetAgent.put(start_position, @visited_mapset)

    {grid, _, _} =
      parsed_input
      |> mapify()

    walk_grid(grid, start_position)

    visited_cells = MapSetAgent.dump(@visited_mapset)

    # possible_loops =
    #   Enum.reduce(visited_cells, 0, fn candidate_cell, acc ->
    #     MapSetAgent.clear(@visited_mapset)
    #     test_grid = Map.put(grid, candidate_cell, "#")

    #     if walk_grid(test_grid, start_position) == :loop do
    #       IO.write(".")
    #       acc + 1
    #     else
    #       acc
    #     end
    #   end)

    # MapSetAgent.stop(@visited_mapset)
    # possible_loops
  end

  # defp test_for_loop(grid, position, direction \\ {-1, 0}) do
  #   next_position
  # end
end
