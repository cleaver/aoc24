import AOC

aoc 2024, 4 do
  @moduledoc """
  https://adventofcode.com/2024/day/4
  """
  import InputHelpers

  @match_pattern "XMAS"
                 |> String.graphemes()
                 |> Enum.with_index()

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    {grid, row_count, col_count} =
      input
      |> parse_input()
      |> mapify()

    scan_xmas(grid, row_count, col_count)
    |> List.flatten()
    |> Enum.sum()
  end

  defp mapify(input) do
    list_of_lists =
      input
      |> Enum.map(&(String.graphemes(&1) |> Enum.with_index()))
      |> Enum.with_index()

    row_count = Enum.count(list_of_lists)
    col_count = list_of_lists |> List.first() |> elem(0) |> Enum.count()

    grid =
      for {row, row_index} <- list_of_lists do
        for {cell, col_index} <- row do
          {{row_index, col_index}, cell}
        end
      end
      |> List.flatten()
      |> Map.new()

    {grid, row_count, col_count}
  end

  defp scan_xmas(grid, row_count, col_count) do
    for row <- 0..(row_count - 1) do
      for col <- 0..(col_count - 1) do
        scan_cell(grid, row, col)
      end
    end
  end

  defp scan_cell(grid, row_index, col_index) do
    moves = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

    match_xmas_count =
      Enum.reduce(moves, 0, fn {row_move, col_move}, acc ->
        # match_xmas(grid, row_index, col_index, row_move, col_move) + acc
        match_string(grid, row_index, col_index, row_move, col_move, @match_pattern) + acc
      end)

    match_xmas_count
  end

  defp match_string(grid, row_index, col_index, row_move, col_move, pattern) do
    pattern
    |> Enum.reduce_while(0, fn {char, index}, acc ->
      if grid[{row_index + row_move * index, col_index + col_move * index}] == char do
        {:cont, 1}
      else
        {:halt, 0}
      end
    end)
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    {grid, row_count, col_count} =
      input
      |> parse_input()
      |> mapify()

    scan_x_mas(grid, row_count, col_count)
    |> List.flatten()
    |> Enum.sum()
  end

  defp scan_x_mas(grid, row_count, col_count) do
    for row <- 1..(row_count - 2) do
      for col <- 1..(col_count - 2) do
        scan_x(grid, row, col)
      end
    end
  end

  defp scan_x(grid, row_index, col_index) do
    if grid[{row_index, col_index}] == "A" and
         ((grid[{row_index - 1, col_index - 1}] == "M" and
             grid[{row_index + 1, col_index + 1}] == "S") or
            (grid[{row_index - 1, col_index - 1}] == "S" and
               grid[{row_index + 1, col_index + 1}] == "M")) and
         ((grid[{row_index + 1, col_index - 1}] == "M" and
             grid[{row_index - 1, col_index + 1}] == "S") or
            (grid[{row_index + 1, col_index - 1}] == "S" and
               grid[{row_index - 1, col_index + 1}] == "M")) do
      1
    else
      0
    end
  end
end
