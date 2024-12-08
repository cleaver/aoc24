defmodule CombinationHelpers do
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
end
