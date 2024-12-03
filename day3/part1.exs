defmodule Part1 do
  defguard is_digit(c) when c in ?0..?9

  def parse(<<"mul(", rest::binary>>, list) do
    first = get_first(rest)

    cond do
      first == nil -> parse(rest, list)
      true -> parse(elem(first, 1), [elem(first, 0) | list])
    end
  end

  def parse(<<_, rest::binary>>, list) do
    parse(rest, list)
  end

  def parse(<<>>, list) do
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
|> Part1.parse([])
|> Enum.sum()
|> IO.inspect()
