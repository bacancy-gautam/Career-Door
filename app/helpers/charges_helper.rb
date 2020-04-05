module ChargesHelper
  def days_left(subscription)
    diff = Time.now.utc - subscription.created_at
    days = ((15.days.seconds - diff) / 1.day).to_i
    (days < 0) ? 0 : days
  end
  
  def subscribed(subscription)
    subscription.subscribed ? "Yes" : "No"
  end
end
