module HomesHelper
  def review(company)
    company_reviews = company.company_reviews.order('created_at DESC')
    if company_reviews.blank?
      0
    else
      company_reviews.average(:review_rating).round(2)
    end
  end
  
  def reviewers(company)
    company.company_reviews.length
  end
end
