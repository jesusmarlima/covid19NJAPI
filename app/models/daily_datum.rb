class DailyDatum < ApplicationRecord
  after_create :send_notification
  attr_reader :deaths

  def send_notification
    NotificationService.fcm_push_notification("new cases entered. Deaths #{@deaths ||= 0}")
  end
end
