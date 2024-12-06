import AOC

aoc 2024, 104 do
  @moduledoc """
  https://adventofcode.com/2024/day/4
  """
  import InputHelpers

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    grid =
      input
      |> parse_input()
      |> Enum.map(&String.graphemes/1)
      |> Grid.new()

    rows = find_rows(grid)
    cols = find_cols(grid)
    diagonals = find_diagonals(grid)

    (rows ++ cols ++ diagonals)
    |> tap(&IO.inspect(length(&1), label: "combined length"))
    |> Enum.map(&count_xmas/1)
    |> IO.inspect(label: "counts")
    |> Enum.sum()
  end

  defp find_rows(grid) do
    IO.puts("rows")

    0..(Grid.row_count(grid) - 1)
    |> Enum.map(fn row ->
      Grid.get_row(grid, row)
    end)
    |> tap(&IO.inspect(length(&1), label: "rows length"))
    |> tap(&IO.inspect(length(hd(&1)), label: "first row"))
  end

  defp find_cols(grid) do
    IO.puts("cols")

    0..(Grid.col_count(grid) - 1)
    |> Enum.map(fn col ->
      Grid.get_column(grid, col)
    end)
    |> tap(&IO.inspect(length(&1), label: "cols length"))
    |> tap(&IO.inspect(length(hd(&1)), label: "first col"))
  end

  defp find_diagonals(grid) do
    IO.puts("diagonals")
    rows = Grid.row_count(grid)
    cols = Grid.col_count(grid)

    IO.inspect("top_down")

    top_down =
      0..(cols - 1)
      |> Enum.map(fn col_index ->
        Grid.get_diagonal(grid, 0, col_index, :down)
      end)
      |> tap(fn row -> Enum.each(row, &IO.inspect(length(&1))) end)

    IO.inspect("left_down")

    left_down =
      1..(rows - 1)
      |> Enum.map(fn row_index ->
        Grid.get_diagonal(grid, row_index, 0, :down)
      end)
      |> tap(fn row -> Enum.each(row, &IO.inspect(length(&1))) end)

    IO.inspect("left_up")

    left_up =
      (rows - 1)..0
      |> Enum.map(fn row_index ->
        Grid.get_diagonal(grid, row_index, 0, :up)
      end)
      |> tap(fn row -> Enum.each(row, &IO.inspect(length(&1))) end)

    IO.inspect("bottom_up")

    bottom_up =
      1..(cols - 1)
      |> Enum.map(fn col_index ->
        Grid.get_diagonal(grid, rows - 1, col_index, :up)
      end)
      |> tap(fn row -> Enum.each(row, &IO.inspect(length(&1))) end)

    (top_down ++ left_down ++ left_up ++ bottom_up)
    |> tap(&IO.inspect(length(&1), label: "diagonals length"))
  end

  defp count_xmas(row) do
    ListHelpers.count_pattern(row, ["X", "M", "A", "S"]) +
      ListHelpers.count_pattern(row, ["S", "A", "M", "X"])
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    input
  end
end
