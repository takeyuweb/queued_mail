# desc "Explaining what the task does"
# task :queued_mail do
#   # Task goes here
# end

namespace :queued_mail do
  desc "QueuedMail delivery task"
  task :work do
    require 'resque/tasks'
    ENV['QUEUES'] = 'mail_queue'
    Rake::Task['resque:work'].invoke
  end
end
