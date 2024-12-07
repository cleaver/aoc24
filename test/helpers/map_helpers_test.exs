defmodule MapHelpersTest do
  use ExUnit.Case
  doctest MapHelpers
  alias MapHelpers

  describe "mapify/1" do
    test "converts list of strings to coordinate map with dimensions" do
      input = [
        "ABC",
        "DEF",
        "GHI"
      ]

      {grid, rows, cols} = MapHelpers.mapify(input)

      assert rows == 3
      assert cols == 3
      assert grid[{0, 0}] == "A"
      assert grid[{0, 1}] == "B"
      assert grid[{0, 2}] == "C"
      assert grid[{1, 0}] == "D"
      assert grid[{1, 1}] == "E"
      assert grid[{1, 2}] == "F"
      assert grid[{2, 0}] == "G"
      assert grid[{2, 1}] == "H"
      assert grid[{2, 2}] == "I"
    end

    test "handles single row input" do
      input = ["ABC"]
      {grid, rows, cols} = MapHelpers.mapify(input)

      assert rows == 1
      assert cols == 3
      assert grid[{0, 0}] == "A"
      assert grid[{0, 1}] == "B"
      assert grid[{0, 2}] == "C"
    end

    test "handles single column input" do
      input = ["A", "B", "C"]
      {grid, rows, cols} = MapHelpers.mapify(input)

      assert rows == 3
      assert cols == 1
      assert grid[{0, 0}] == "A"
      assert grid[{1, 0}] == "B"
      assert grid[{2, 0}] == "C"
    end

    test "handles empty input" do
      input = []
      {grid, rows, cols} = MapHelpers.mapify(input)

      assert rows == 0
      assert cols == 0
      assert grid == %{}
    end
  end
end
