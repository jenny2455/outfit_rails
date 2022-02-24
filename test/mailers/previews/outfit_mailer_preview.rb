# Preview all emails at http://localhost:3000/rails/mailers/outfit_mailer
class OutfitMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/outfit_mailer/outfit_generated
  def outfit_generated
    OutfitMailer.outfit_generated
  end

end
