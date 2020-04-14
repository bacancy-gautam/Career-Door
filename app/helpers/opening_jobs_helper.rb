module OpeningJobsHelper
  
  def eligible?(job,current_user)
    current_user.years_of_experience >= job.experience
  end
  
  def interested?(job)
    current_user.opening_jobs.where(id: job.id).blank?
  end
  
  def applied?(job)
    if !interested?(job)
      jobb = current_user.interested_people.find_by(opening_job_id: job.id)
      jobb.nil? ? false : jobb.applied?
    end
  end

  def opened(job)
    job.open ? "Close" : "Open"
  end
end
