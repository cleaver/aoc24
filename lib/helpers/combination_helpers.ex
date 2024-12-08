defmodule CombinationHelpers do
  def combine(_, 0), do: [[]]

  def combine(terms, count) do
    acc =
      for term <- terms do
        [term]
      end

    combine(terms, count - 1, acc)
  end

  def combine(_, 0, acc), do: acc

  def combine(terms, count, acc) do
    new_acc =
      for combination <- acc, term <- terms do
        [term | combination]
      end

    combine(terms, count - 1, new_acc)
  end

  def permute(_terms, 0), do: [[]]
  def permute([], _count), do: []
  def permute(terms, 1), do: Enum.map(terms, &[&1])

  def permute(terms, count) when count > 1 do
    for term <- terms,
        permutation <- permute(List.delete(terms, term), count - 1),
        do: [term | permutation]
  end
end
