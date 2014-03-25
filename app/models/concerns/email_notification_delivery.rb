require 'active_support/concern'

module EmailNotificationDelivery
  extend ActiveSupport::Concern

  included do
    after_create do |model|
      if ClinicMailer.public_send(model.class::EMAIL_NOTIFICATION_METHOD, model).deliver
        Rails.logger.info("Sent #{model.class.model_name.human} notification for #{model.id}")
        true
      else
        Rails.logger.info("Couldn't send #{model.class.model_name.human} notification for #{model.id}")
        false
      end
    end
  end
end
