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
end
