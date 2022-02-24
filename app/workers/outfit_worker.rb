class OufitGeneraterWorker
    include Sidekiq::Worker 
    include Sidekiq::Schedulable
    # sidekiq_options :queue => :mailer

    recurrence { daily }

    def perform
        User.find_each do |user|
        OutfitMailer.outfit_generated(user)
    end
end