Rails.application.routes.draw do

  mount QueuedMail::Engine => "/queued_mail"
end
