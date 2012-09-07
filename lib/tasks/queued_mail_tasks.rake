# desc "Explaining what the task does"
# task :queued_mail do
#   # Task goes here
# end

namespace :queued_mail do
  desc "QueuedMail delivery task"
  task :work do
    require 'resque/tasks'
    ENV['QUEUES'] = Rails.application.config.mail_queue_name.to_s
    Rake::Task['resque:work'].invoke
  end
end
