require "test_helper"

class OutfitMailerTest < ActionMailer::TestCase
  test "outfit_generated" do
    mail = OutfitMailer.outfit_generated
    assert_equal "Outfit generated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
