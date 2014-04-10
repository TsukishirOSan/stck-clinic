require 'active_support/concern'

module EmailNotificationDelivery
  extend ActiveSupport::Concern

  included do
    after_create do |model|
      if ENV['SUSPEND_EMAIL'].present? || Rails.env.test?
        Rails.logger.info("Not sending #{model.class.model_name.human} notification for #{model.id} because SUSPEND_EMAIL=#{ENV['SUSPEND_EMAIL']}")
      else
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
end
