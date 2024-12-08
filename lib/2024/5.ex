import AOC

aoc 2024, 5 do
  @moduledoc """
  https://adventofcode.com/2024/day/5
  """

  import InputHelpers

  @doc """
      iex> p1(example_string())
  """
  def p1(input) do
    # {rules, updates} =
    input
    |> parse_rules_and_updates()
    |> exclude_invalid_updates
    |> Enum.map(fn update ->
      update
      |> get_page_list()
      |> get_middle_element()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp parse_rules_and_updates(input) do
    [raw_rules, raw_updates] = input |> String.split("\n\n")
    {parse_rules(raw_rules), parse_updates(raw_updates)}
  end

  defp parse_rules(raw_rules) do
    raw_rules
    |> parse_input()
    |> Enum.map(fn line -> String.split(line, "|") end)
    |> Enum.reduce(%{}, fn [first, second], acc ->
      acc
      |> index_rule(first, {first, second})
      |> index_rule(second, {first, second})
    end)
  end

  defp index_rule(map, key, value) do
    Map.update(map, key, MapSet.new(), fn set -> MapSet.put(set, value) end)
  end

  defp parse_updates(raw_updates) do
    raw_updates
    |> parse_input()
    |> Enum.map(&(" " <> &1 <> " "))
  end

  defp exclude_invalid_updates({rules, updates}) do
    updates
    |> Enum.filter(fn update ->
      is_valid?(update, rules)
    end)
  end

  defp is_valid?(update, rules) do
    update
    |> get_page_list()
    |> get_matching_rules(rules)
    |> Enum.all?(&validate_rule(&1, update))
  end

  defp get_page_list(update) do
    update
    |> String.trim()
    |> String.split(",")
  end

  def validate_rule({first, second} = _rule, update) do
    index_compare(page_index(update, first), page_index(update, second))
  end

  def page_index(update, page) do
    regex = Regex.compile!("\\D#{page}\\D")

    case Regex.run(regex, update, return: :index) do
      [{start, _end}] -> start
      _ -> nil
    end
  end

  defp index_compare(nil, _), do: true
  defp index_compare(_, nil), do: true
  defp index_compare(first, second), do: first < second

  defp get_matching_rules(list_of_pages, rules) do
    list_of_pages
    |> Enum.reduce(MapSet.new(), fn page, acc ->
      matching_rules = rules[page]

      acc
      |> MapSet.union(matching_rules)
    end)
  end

  defp get_middle_element(list) do
    list
    |> Enum.at(length(list) |> div(2))
  end

  @doc """
      iex> p2(example_string())
  """
  def p2(input) do
    # {rules, updates} =
    input
    |> parse_rules_and_updates()
    |> exclude_valid_updates()
    |> fix_invalid_updates()
    |> Enum.map(fn update ->
      update
      |> get_middle_element()
      |> String.to_integer()
    end)
    |> Enum.sum()
  end

  defp exclude_valid_updates({rules, updates}) do
    invalid_updates =
      updates
      |> Enum.filter(fn update ->
        !is_valid?(update, rules)
      end)

    {rules, invalid_updates}
  end

  defp fix_invalid_updates({rules, updates}) do
    updates
    |> Enum.map(fn update ->
      list_of_pages =
        get_page_list(update)

      matching_rules = get_matching_rules(list_of_pages, rules)

      update_as_map =
        list_of_pages
        |> Enum.with_index()
        |> Map.new()

      reorder_pages(update_as_map, matching_rules)
      |> Map.to_list()
      |> Enum.sort(fn {_, first}, {_, second} -> first < second end)
      |> Enum.map(&elem(&1, 0))
    end)
  end

  defp reorder_pages(update_as_map, matching_rules) do
    matching_rules
    |> Enum.reduce(update_as_map, fn {first, second} = _rule, acc ->
      first_position = Map.get(acc, first)
      second_position = Map.get(acc, second)

      if !is_nil(first_position) && !is_nil(second_position) && first_position > second_position do
        acc
        |> Map.put(first, second_position)
        |> Map.put(second, first_position)
      else
        acc
      end
    end)
  end
end
