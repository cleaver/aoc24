defmodule ListHelpersTest do
  use ExUnit.Case
  doctest ListHelpers

  describe "count_pattern/2" do
    test "counts basic patterns" do
      assert ListHelpers.count_pattern([1, 2, 1, 2], [1, 2]) == 2
      assert ListHelpers.count_pattern([1, 2, 3], [1, 2]) == 1
      assert ListHelpers.count_pattern(["1", "2", "1", "1", "2"], ["1", "2"]) == 2
      assert ListHelpers.count_pattern(["1", "2", "3"], ["1", "2"]) == 1
    end

    test "counts overlapping patterns" do
      assert ListHelpers.count_pattern([1, 1, 1], [1, 1]) == 2
      assert ListHelpers.count_pattern([1, 2, 1, 2, 1], [1, 2, 1]) == 2
    end

    test "handles empty lists" do
      assert ListHelpers.count_pattern([], [1, 2]) == 0
      assert ListHelpers.count_pattern([1, 2, 3], []) == 0
    end

    test "handles patterns longer than list" do
      assert ListHelpers.count_pattern([1, 2], [1, 2, 3]) == 0
    end

    test "returns 0 when pattern not found" do
      assert ListHelpers.count_pattern([1, 2, 3], [4, 5]) == 0
    end
  end

  describe "sort_list_of_lists/1" do
    test "sorts basic lists of lists" do
      input = [[3, 2], [1, 2], [2, 1]]
      expected = [[1, 2], [2, 1], [3, 2]]
      assert ListHelpers.sort_list_of_lists(input) == expected
    end

    test "handles empty list" do
      assert ListHelpers.sort_list_of_lists([]) == []
    end

    test "handles lists with empty sublists" do
      input = [[1, 2], [], [2]]
      expected = [[], [1, 2], [2]]
      assert ListHelpers.sort_list_of_lists(input) == expected
    end

    test "sorts lists of different lengths" do
      input = [[1, 2, 3], [1, 2], [1]]
      expected = [[1], [1, 2], [1, 2, 3]]
      assert ListHelpers.sort_list_of_lists(input) == expected
    end

    test "sorts lists with equal elements" do
      input = [[1, 1], [1, 1], [1]]
      expected = [[1], [1, 1], [1, 1]]
      assert ListHelpers.sort_list_of_lists(input) == expected
    end

    test "sorts string lists" do
      input = [["b"], ["a", "b"], ["a"]]
      expected = [["a"], ["a", "b"], ["b"]]
      assert ListHelpers.sort_list_of_lists(input) == expected
    end
  end
end
