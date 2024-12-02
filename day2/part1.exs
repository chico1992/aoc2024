defmodule Part1 do
  def valid?([x, x | _]), do: false
  def valid?([x, y | rest]) when 0 < x - y and x - y <= 3, do: valid?([y | rest], :dec)
  def valid?([x, y | rest]) when 0 > x - y and x - y >= -3, do: valid?([y | rest], :inc)
  def valid?(_), do: false
  def valid?([x, x], _), do: false
  def valid?([x, y], :dec) when 0 < x - y and x - y <= 3, do: true
  def valid?([x, y], :inc) when 0 > x - y and x - y >= -3, do: true
  def valid?([x, x | _rest], _), do: false
  def valid?([x, y | rest], :dec) when 0 < x - y and x - y <= 3, do: valid?([y | rest], :dec)
  def valid?([x, y | rest], :inc) when 0 > x - y and x - y >= -3, do: valid?([y | rest], :inc)
  def valid?(_, _), do: false
end

File.read!("./input")
|> String.split("\n", trim: true)
|> Enum.map(fn x ->
  String.split(x, ~r{\s+}, trim: true)
  |> Enum.map(&String.to_integer/1)
end)
|> Enum.filter(&Part1.valid?/1)
|> length()
|> IO.puts()
