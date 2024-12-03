defmodule Part2 do
  defguard is_digit(c) when c in ?0..?9
  def parse(<<"do()", rest::binary>>, list, _), do: parse(rest, list, :do)
  def parse(<<"don't()", rest::binary>>, list, _), do: parse(rest, list, :dont)

  def parse(<<"mul(", rest::binary>>, list, :do) do
    first = get_first(rest)

    cond do
      first == nil -> parse(rest, list, :do)
      true -> parse(elem(first, 1), [elem(first, 0) | list], :do)
    end
  end

  def parse(<<_, rest::binary>>, list, opp) do
    parse(rest, list, opp)
  end

  def parse(<<>>, list, _) do
    list
  end

  def get_first(<<x::utf8, y::utf8, z::utf8, ",", rest::binary>>)
      when is_digit(x) and is_digit(y) and is_digit(z) do
    second = get_second(rest)

    cond do
      second == nil ->
        nil

      true ->
        {String.to_integer(IO.iodata_to_binary([x, y, z])) * elem(second, 0), elem(second, 1)}
    end
  end

  def get_first(<<x::utf8, y::utf8, ",", rest::binary>>) when is_digit(x) and is_digit(y) do
    second = get_second(rest)

    cond do
      second == nil -> nil
      true -> {String.to_integer(IO.iodata_to_binary([x, y])) * elem(second, 0), elem(second, 1)}
    end
  end

  def get_first(<<x::utf8, ",", rest::binary>>) when is_digit(x) do
    second = get_second(rest)

    cond do
      second == nil -> nil
      true -> {String.to_integer(IO.iodata_to_binary([x])) * elem(second, 0), elem(second, 1)}
    end
  end

  def get_first(_), do: nil

  def get_second(<<x::utf8, y::utf8, z::utf8, ")", rest::binary>>)
      when is_digit(x) and is_digit(y) and is_digit(z) do
    {String.to_integer(IO.iodata_to_binary([x, y, z])), rest}
  end

  def get_second(<<x::utf8, y::utf8, ")", rest::binary>>) when is_digit(x) and is_digit(y) do
    {String.to_integer(IO.iodata_to_binary([x, y])), rest}
  end

  def get_second(<<x::utf8, ")", rest::binary>>) when is_digit(x) do
    {String.to_integer(IO.iodata_to_binary([x])), rest}
  end

  def get_second(_), do: nil
end

File.read!("./input")
|> Part2.parse([], :do)
|> Enum.sum()
|> IO.inspect()
