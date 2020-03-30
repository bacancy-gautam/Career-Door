module OpeningJobsHelper
  def interested?(job)
    current_user.opening_jobs.where(id: job.id).blank?
  end
  
  def applied?(job)
    if !interested?(job)
      jobb = current_user.interested_people.find_by(opening_job_id: job.id)
      jobb.applied?
    end
  end
end
