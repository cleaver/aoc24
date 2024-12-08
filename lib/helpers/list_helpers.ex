defmodule ListHelpers do
  @doc """
  Counts the number of times a pattern list appears in a list.
  ## Examples

  iex> ListHelpers.count_pattern(["X", "M", "A", "S", "X", "M", "A", "S"], ["X", "M", "A", "S"])
  2

  iex> ListHelpers.count_pattern(["X", "M", "A", "S", "X", "M", "A", "S"], ["S", "A", "M", "X"])
  0
  """
  def count_pattern(list, pattern_list) when length(list) < length(pattern_list), do: 0
  def count_pattern([], _pattern_list), do: 0
  def count_pattern(_list, []), do: 0

  def count_pattern(list, pattern_list) do
    list_length = length(list)
    pattern_length = length(pattern_list)

    Enum.reduce(0..(list_length - pattern_length), 0, fn i, acc ->
      if Enum.slice(list, i, pattern_length) == pattern_list do
        acc + 1
      else
        acc
      end
    end)
  end

  @doc """
  Sorts a list of lists.
  """
  def sort_list_of_lists(list) do
    Enum.sort(list, fn a, b ->
      compare_lists(a, b)
    end)
  end

  defp compare_lists([], []), do: true
  defp compare_lists([], _), do: true
  defp compare_lists(_, []), do: false
  defp compare_lists([x | _], [y | _]) when x < y, do: true
  defp compare_lists([x | _], [y | _]) when x > y, do: false
  defp compare_lists([_ | xs], [_ | ys]), do: compare_lists(xs, ys)
end
