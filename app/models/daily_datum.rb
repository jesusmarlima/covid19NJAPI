class DailyDatum < ApplicationRecord
  after_create :send_notification

  def send_notification
    NotificationService.fcm_push_notification("new cases entered. Deaths #{self.deaths ||= 0}")
  end
end
