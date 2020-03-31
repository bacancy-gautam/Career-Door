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
end
