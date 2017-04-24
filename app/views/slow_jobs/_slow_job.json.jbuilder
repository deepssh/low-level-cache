json.extract! slow_job, :id, :name, :requested_time, :returned_at, :description, :created_at, :updated_at
json.url slow_job_url(slow_job, format: :json)
