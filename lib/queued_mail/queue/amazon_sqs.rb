module QueuedMail
  module Queue
    module AmazonSqs
      module ModuleMethods
        def enqueue(message_id)
          begin
            sent_message = queue.send_message(JSON.dump('message_id' => message_id))
            Rails.logger.info "send message_id:#{sent_message.message_id} md5:#{sent_message.md5} (id:#{message_id})"
          rescue => e
            Rails.logger.error e
          end
        end
        
        def dequeue
          raise "TODO"
        end
        
        def task(do_retry = true)
          if ENV['PIDFILE']
            File.open(ENV['PIDFILE'], 'w'){ |f| f << Process.pid }
          end

          begin
            queue.poll(poll_interval: 5, batch_size: 1) do |received_message|
              begin
                Rails.logger.info "receive message_id:#{received_message.id} md5:#{received_message.md5}"
                args = JSON.parse(received_message.body)
                QueuedMail::Job.perform(args)
              rescue => e
                received_message.visibility_timeout = 60
                raise e
              end
            end
          rescue SignalException
            # C-c
          rescue Exception => e
            Rails.logger.error "#{e.message}\n\n#{e.backtrace.join("\n")}"
            raise e
          end
        end

        private
        def sqs
          @sqs ||= AWS::SQS.new
        end
        
        def queue
          sqs.queues.named(Rails.application.config.mail_queue_name.to_s)
        end
      end
      extend ModuleMethods
    end
  end
end
