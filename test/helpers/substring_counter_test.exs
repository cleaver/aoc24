defmodule SubstringCounterTest do
  use ExUnit.Case
  doctest SubstringCounter
  alias SubstringCounter

  describe "count/2" do
    test "counts non-overlapping occurrences of a substring" do
      assert SubstringCounter.count("banana", "ana") == 1
      assert SubstringCounter.count("banana", "an") == 2
      assert SubstringCounter.count("hello", "l") == 2
    end

    test "returns 0 when substring is not found" do
      assert SubstringCounter.count("hello", "x") == 0
    end

    test "handles empty strings" do
      assert SubstringCounter.count("", "x") == 0
      assert SubstringCounter.count("hello", "") == 0
    end
  end

  describe "count_overlapping/2" do
    test "counts overlapping occurrences of a substring" do
      assert SubstringCounter.count_overlapping("aaaaa", "aa") == 4
      assert SubstringCounter.count_overlapping("banana", "ana") == 2
      assert SubstringCounter.count_overlapping("111111", "111") == 4
    end

    test "returns 0 when substring is not found" do
      assert SubstringCounter.count_overlapping("hello", "x") == 0
    end

    test "handles empty strings" do
      assert SubstringCounter.count_overlapping("", "x") == 0
      assert SubstringCounter.count_overlapping("hello", "") == 0
    end
  end
end
