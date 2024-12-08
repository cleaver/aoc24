defmodule CombinationHelpersTest do
  use ExUnit.Case
  doctest CombinationHelpers
  alias CombinationHelpers

  describe "combine/2" do
    test "generates combinations of length 2" do
      result =
        CombinationHelpers.combine([1, 2, 3], 2)
        |> ListHelpers.sort_list_of_lists()

      expected =
        [[1, 1], [1, 2], [1, 3], [2, 1], [2, 2], [2, 3], [3, 1], [3, 2], [3, 3]]

      assert result == expected
    end

    test "generates combinations of length 3" do
      result = CombinationHelpers.combine([1, 2], 3) |> ListHelpers.sort_list_of_lists()

      expected =
        [
          [1, 1, 1],
          [1, 1, 2],
          [1, 2, 1],
          [1, 2, 2],
          [2, 1, 1],
          [2, 1, 2],
          [2, 2, 1],
          [2, 2, 2]
        ]

      assert result == expected
    end

    test "works with strings" do
      result = CombinationHelpers.combine(["A", "B"], 2) |> ListHelpers.sort_list_of_lists()

      expected =
        [["B", "B"], ["B", "A"], ["A", "B"], ["A", "A"]] |> ListHelpers.sort_list_of_lists()

      assert result == expected
    end

    test "handles single length combinations" do
      result = CombinationHelpers.combine([1, 2, 3], 1) |> ListHelpers.sort_list_of_lists()
      expected = [[1], [2], [3]]

      assert result == expected
    end

    test "returns empty list for empty input" do
      result = CombinationHelpers.combine([], 2)
      assert result == []
    end

    test "returns [[]] for count 0" do
      assert CombinationHelpers.combine([1, 2], 0) == [[]]
    end
  end

  describe "permute/2" do
    test "generates permutations of length 2" do
      result = CombinationHelpers.permute([1, 2], 2) |> ListHelpers.sort_list_of_lists()
      expected = [[1, 2], [2, 1]] |> ListHelpers.sort_list_of_lists()
      assert result == expected
    end

    test "generates permutations of length 3" do
      result = CombinationHelpers.permute([1, 2, 3], 3) |> ListHelpers.sort_list_of_lists()

      expected =
        [
          [1, 2, 3],
          [1, 3, 2],
          [2, 1, 3],
          [2, 3, 1],
          [3, 1, 2],
          [3, 2, 1]
        ]
        |> ListHelpers.sort_list_of_lists()

      assert result == expected
    end

    test "handles single length permutations" do
      result = CombinationHelpers.permute([1, 2, 3], 1) |> ListHelpers.sort_list_of_lists()
      expected = [[1], [2], [3]]
      assert result == expected
    end

    test "works with strings" do
      result = CombinationHelpers.permute(["A", "B"], 2) |> ListHelpers.sort_list_of_lists()
      expected = [["A", "B"], ["B", "A"]] |> ListHelpers.sort_list_of_lists()
      assert result == expected
    end

    test "returns [[]] for count 0" do
      assert CombinationHelpers.permute([1, 2], 0) == [[]]
    end

    test "returns [] for empty input" do
      assert CombinationHelpers.permute([], 2) == []
    end

    test "returns [] when count greater than input length" do
      assert CombinationHelpers.permute([1, 2], 3) == []
    end
  end
end
