class SlowJob < ActiveRecord::Base
  default_scope { order(:requested_time) }
  def time_taken
    returned_at - requested_time  if returned_at.present?
  end
  def respond_slow name, description, requested_time
    # long running method for name, description, requested_time
    SlowJob.create(name: name,
    description: description,
    requested_time: requested_time,
    returned_at: Time.now.to_i)
  end
  # handle_asynchronously :slow_response, :run_at => Proc.new { 5.minutes.from_now }

  def update_slow_job
    self.update!(returned_at: Time.now.to_i)
    return "updated"
  end
  handle_asynchronously :update_slow_job, :run_at => Proc.new { 1.minutes.from_now }


  # SlowJob.create!(name: name, description: description, requested_time: requested_time,
end
