defmodule Grid do
  @moduledoc """
    A module to handle 2D arrays.
  """
  def new(row_count, col_count, value \\ nil) do
    value
    |> List.duplicate(col_count)
    |> Arrays.new()
    |> List.duplicate(row_count)
    |> Arrays.new()
  end

  def new(list_of_lists) do
    list_of_lists
    |> Enum.map(&Arrays.new(&1))
    |> Arrays.new()
  end

  def set(grid, row, col, value) do
    new_row = grid |> Arrays.get(row) |> Arrays.replace(col, value)
    grid |> Arrays.replace(row, new_row)
  end

  def get(grid, row, col) do
    try do
      grid
      |> Arrays.get(row)
      |> Arrays.get(col)
    rescue
      _ -> nil
    end
  end

  def row_count(grid) do
    grid |> Arrays.size()
  end

  def col_count(grid) do
    grid |> Arrays.get(0) |> Arrays.size()
  end

  def get_row(grid, row_index) do
    grid
    |> Arrays.get(row_index)
    |> Arrays.to_list()
  end

  def get_column(grid, col_index) do
    0..(row_count(grid) - 1)
    |> Enum.map(fn row_index -> get(grid, row_index, col_index) end)
  end

  def get_diagonal(grid, row, col, direction) do
    max_row = row_count(grid) - 1
    max_col = col_count(grid) - 1

    do_diagonal(grid, row, col, direction, max_row, max_col, [])
  end

  defp do_diagonal(_grid, row, col, _direction, max_row, max_col, acc)
       when row < 0 or row > max_row or col < 0 or col > max_col do
    Enum.reverse(acc)
  end

  defp do_diagonal(grid, row, col, direction, max_row, max_col, acc) do
    {next_row, next_col} =
      case direction do
        :down -> {row + 1, col + 1}
        :up -> {row - 1, col + 1}
      end

    do_diagonal(
      grid,
      next_row,
      next_col,
      direction,
      max_row,
      max_col,
      [get(grid, row, col) | acc]
    )
  end
end
