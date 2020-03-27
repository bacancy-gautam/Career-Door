class UserResume < ApplicationRecord
  belongs_to :user
  mount_uploader :resume, ResumeUploader
end
