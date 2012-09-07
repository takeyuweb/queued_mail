module QueuedMail
  module Queue
    module Resque
      autoload :DeliverEmailJob, 'queued_mail/queue/resque/deliver_email_job'
      module ModuleMethods
        def enqueue(message_id)
          ::Resque.enqueue(QueuedMail::Queue::Resque::DeliverEmailJob, message_id: message_id)
        end
        
        def dequeue
          raise "TODO"
        end
        
        def task
          require 'resque/tasks'
          ENV['QUEUES'] = Rails.application.config.mail_queue_name.to_s
          Rake::Task['resque:work'].invoke
        end
      end
      extend ModuleMethods
    end
  end
end
