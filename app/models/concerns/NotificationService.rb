require 'fcm'

class NotificationService

def self.fcm_push_notification(message)

    fcm_client = FCM.new(Rails.application.credentials[:fcm_key])
    options = { "notification": {
      "title": "Covid19NJStats",
      "body": message
      }
    }

    registration_ids = Channel.all.pluck(:token)

    registration_ids.each_slice(20) do |registration_id|
      response = fcm_client.send(registration_id, options)
      puts response
    end
  end

end
