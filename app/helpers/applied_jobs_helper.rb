module AppliedJobsHelper
  def find_resume(resume_id)
    resume = Resume.find_by(id: resume_id)
  end

  def cgpa_valied?(job_application)
    job = OpeningJob.find_by(id: job_application.opening_job_id)
    job_application.cgpa.to_f >= job.cgpa  
  end
end
