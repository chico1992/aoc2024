[left, right] =
  File.read!("./input")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x ->
    String.split(x, ~r{\s+}, trim: true) |> Enum.map(&String.to_integer/1) |> List.to_tuple()
  end)
  |> Enum.unzip()
  |> Tuple.to_list()

freqs = Enum.frequencies(right)

left
|> Enum.reduce(0, fn x, acc ->
  acc + x * Map.get(freqs, x, 0)
end)
|> IO.puts()
