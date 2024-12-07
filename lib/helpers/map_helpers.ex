defmodule MapHelpers do
  def mapify([]), do: {%{}, 0, 0}

  def mapify(input) do
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
end
