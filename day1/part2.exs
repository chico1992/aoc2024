[left, right] =
  File.read!("./input")
  |> String.split("\n", trim: true)
  |> Enum.map(fn x -> String.split(x, ~r{\s+}, trim: true) |> List.to_tuple() end)
  |> Enum.unzip()
  |> Tuple.to_list()
  |> Enum.map(fn x ->
    x
    |> Enum.map(&String.to_integer/1)
  end)

freqs = Enum.frequencies(right)

left
|> Enum.reduce(0, fn x, acc ->
  acc + x * Map.get(freqs, x, 0)
end)
|> IO.puts()
