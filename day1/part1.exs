File.read!("./input")
|> String.split("\n", trim: true)
|> Enum.map(fn x -> String.split(x, ~r{\s+}, trim: true) |> List.to_tuple() end)
|> Enum.unzip()
|> Tuple.to_list()
|> Enum.map(fn x ->
  x
  |> Enum.map(&String.to_integer/1)
  |> Enum.sort()
end)
|> Enum.zip_reduce(0, fn [l, r], acc ->
  acc + abs(r - l)
end)
|> IO.puts()
