module CompaniesHelper
  def company_approved?
    current_company.approved?
  end
  
  def company_subscribed?
    current_company.subscription.subscribed?
  end

  def remaining_days_more_than_zero?(days)
      days > 0
  end

  def remaining_days_more_than_ten?(days)
    days > 10
  end

  def un_subscribe(company)
    company.update(approved: false)
    company.subscription.update(un_subscribe_date:  DateTime.now)
  end

  def subscription(company)
    if Subscription.exists?(company_id: company.id)
      company.subscription.update(subscribed: true)
      subscription = company.subscription
    else
      subscription = @company.build_subscription
    end
  end

  def remaining_days(company)
    if current_company and company.approved == true
      if company.subscription.un_subscribe_date.nil?
        begin  
          diff = Time.now.utc - current_company.subscription.created_at
          remaining_days = ((15.days.seconds - diff) / 1.day).to_i
        rescue StandardError
          remaining_days = 0
        end
      else
        day_difference = company.subscription.un_subscribe_date - company.subscription.subscription_date
        remaining_days = 30 - day_difference.to_i
      end      
    end
  end
end
