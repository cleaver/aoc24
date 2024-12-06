defmodule SubstringCounter do
  def count(_, ""), do: 0

  def count(string, substring) do
    Regex.scan(~r/#{Regex.escape(substring)}/, string) |> length()
  end

  def count_overlapping(_, ""), do: 0

  def count_overlapping("", _), do: 0

  def count_overlapping(string, substring) do
    string_length = String.length(string)
    substr_length = String.length(substring)

    IO.inspect({string_length, substr_length}, label: "lengths")

    0..(string_length - substr_length)
    |> Enum.count(fn start ->
      IO.inspect(start, label: "start")
      String.slice(string, start, substr_length) == substring
    end)
  end
end
