# Calculates the score based on the Elo ranking system
# https://metinmediamath.wordpress.com/2013/11/27/how-to-calculate-the-elo-rating-including-example/
# http://www.gautamnarula.com/rating/

defmodule Elo do
  @k 32

  def calculate(old_score, opponent_old_score, win) do
    old_score + @k * (score(win) - e_value(old_score, opponent_old_score))
  end

  defp e_value(old_score, opponent_old_score) do
    1 / (:math.pow(10, -(old_score - opponent_old_score) / 400) + 1)
  end

  defp score(win) do
    if win, do: 1, else: 0
  end
end
