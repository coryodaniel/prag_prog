defmodule PragProg.Ch8.Exercises.Subscriber do
  defstruct name: "", paid: false, over_18: true
  alias PragProg.Ch8.Exercises.Subscriber

  def send_paid_account_features_spam(subscriber = %Subscriber{}) do
    !subscriber.paid
  end

  def send_investment_opportunity_spam(subscriber = %Subscriber{}) do
    subscriber.over_18
  end
end
