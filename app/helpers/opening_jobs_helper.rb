module OpeningJobsHelper
  def interested?(job)
    current_user.opening_jobs.where(id: job.id).blank?
  end
  
  def applied?(job)
    if !interested?(job)
      jobb = current_user.interested_people.where(opening_job_id: job.id).first
      jobb.applied?
    end
  end
end
