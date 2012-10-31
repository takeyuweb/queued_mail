module QueuedMail
  class Message < ActiveRecord::Base
    attr_accessible :source
  end
end
