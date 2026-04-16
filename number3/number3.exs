defmodule Number3 do
  def main do
    input = IO.read(:all)
    tokens = String.split(input, ~r/\s+/, trim: true) |> Enum.map(&String.to_integer/1)

    case tokens do
      [amount | rest] when amount >= 0 ->
        if length(rest) >= amount do
          numbers = Enum.take(rest, amount)
          if Enum.all?(numbers, &(&1 > 0)) do
            process_numbers(numbers)
          else
            IO.puts("Введите коректное количество чисел, числа должны быть положительные")
          end
        else
          IO.puts("Введите коректное количество чисел, числа должны быть положительные")
        end

      _ ->
        IO.puts("Введите коректное количество чисел, числа должны быть положительные")
    end
  end

  defp process_numbers(numbers) do
    Enum.each(numbers, &check_palindrome/1)
    IO.puts("")
  end

  defp check_palindrome(x) when x > 99 and x < 1000 do
    unit = rem(x, 10)
    tens = rem(x, 100) - unit
    hung = rem(x, 1000) - tens - unit
    reversed = unit * 100 + tens + div(hung, 100)

    if reversed == x do
      IO.write("Yes ")
    else
      IO.write("No ")
    end
  end

  defp check_palindrome(_) do
    IO.write("- ")
  end
end

Number3.main()
