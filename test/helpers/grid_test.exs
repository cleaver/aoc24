defmodule GridTest do
  use ExUnit.Case
  doctest Grid
  alias Grid

  describe "new/1" do
    test "creates a grid from a list of lists" do
      list_of_lists = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]

      grid = Grid.new(list_of_lists)

      assert Grid.get(grid, 0, 0) == 1
      assert Grid.get(grid, 1, 1) == 5
      assert Grid.get(grid, 2, 2) == 9
    end
  end

  describe "new/3" do
    test "creates a grid with given dimensions and default value" do
      grid = Grid.new(3, 3, 0)

      assert Grid.get(grid, 0, 0) == 0
      assert Grid.get(grid, 1, 1) == 0
      assert Grid.get(grid, 2, 2) == 0
    end
  end

  describe "set/4" do
    test "sets a value in the grid" do
      grid = Grid.new(3, 3, 0)
      grid = Grid.set(grid, 1, 1, 5)

      assert Grid.get(grid, 1, 1) == 5
    end
  end

  describe "get/3" do
    test "gets a value from the grid" do
      grid = Grid.new(3, 3, 0)

      assert Grid.get(grid, 0, 0) == 0
    end
  end

  describe "row_count/1" do
    test "returns the number of rows in the grid" do
      grid = Grid.new(3, 3, 0)

      assert Grid.row_count(grid) == 3
    end
  end

  describe "col_count/1" do
    test "returns the number of columns in the grid" do
      grid = Grid.new(3, 3, 0)

      assert Grid.col_count(grid) == 3
    end
  end

  describe "get_row/2" do
    test "returns a row from the grid" do
      list_of_lists = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]

      grid = Grid.new(list_of_lists)

      assert Grid.get_row(grid, 0) == [1, 2, 3]
      assert Grid.get_row(grid, 1) == [4, 5, 6]
      assert Grid.get_row(grid, 2) == [7, 8, 9]
    end
  end

  describe "get_column/2" do
    test "returns a column from the grid" do
      list_of_lists = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]

      grid = Grid.new(list_of_lists)

      assert Grid.get_column(grid, 0) == [1, 4, 7]
      assert Grid.get_column(grid, 1) == [2, 5, 8]
      assert Grid.get_column(grid, 2) == [3, 6, 9]
    end
  end

  describe "get_diagonal/4" do
    test "returns diagonals from the grid" do
      list_of_lists = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 16]
      ]

      grid = Grid.new(list_of_lists)

      # Downward diagonals
      assert Grid.get_diagonal(grid, 0, 0, :down) == [1, 6, 11, 16]
      assert Grid.get_diagonal(grid, 0, 1, :down) == [2, 7, 12]
      assert Grid.get_diagonal(grid, 1, 0, :down) == [5, 10, 15]

      # Upward diagonals
      assert Grid.get_diagonal(grid, 3, 0, :up) == [13, 10, 7, 4]
      assert Grid.get_diagonal(grid, 3, 1, :up) == [14, 11, 8]
      assert Grid.get_diagonal(grid, 2, 0, :up) == [9, 6, 3]
    end
  end
end
