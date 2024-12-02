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

defmodule Part2 do
  def valid?(i) do
    if Part1.valid?(i) do
      true
    else
      partial_valid?(i)
    end
  end

  def partial_valid?([h | tail]) do
    if Part1.valid?(tail) do
      true
    else
      partial_valid?(tail, [h])
    end
  end

  def partial_valid?([_], elems) do
    Part1.valid?(elems)
  end

  def partial_valid?([h | tail], elems) do
    if Part1.valid?(Enum.concat(Enum.reverse(elems), tail)) do
      true
    else
      partial_valid?(tail, [h | elems])
    end
  end
end

File.read!("./input")
|> String.split("\n", trim: true)
|> Enum.map(fn x ->
  String.split(x, ~r{\s+}, trim: true)
  |> Enum.map(&String.to_integer/1)
end)
|> Enum.filter(&Part2.valid?/1)
|> length()
|> IO.puts()
