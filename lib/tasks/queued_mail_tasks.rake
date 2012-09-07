# desc "Explaining what the task does"
# task :queued_mail do
#   # Task goes here
# end

namespace :queued_mail do
  desc "QueuedMail delivery task"
  task :work do
    instance_eval "QueuedMail::Queue::#{ Rails.application.config.mail_queue_service.to_s.camelcase }.task"
  end
end
