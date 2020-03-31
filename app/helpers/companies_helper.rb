module CompaniesHelper
  def company_approved?
    current_company.approved?
  end
end
