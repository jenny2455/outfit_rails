class OutfitMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.outfit_mailer.outfit_generated.subject
  #
  def outfit_generated
    @greeting = "Hi"
    

    mail(to: User.all.pluck(:email), subject: "Your Outfit For Today")
    
  end
end
