module QueuedMail
  module Queue
    module Resque
      module ModuleMethods
        def enqueue(message_id)
          ::Resque.enqueue(QueuedMail::Job, message_id: message_id)
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
