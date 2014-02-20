# == Schema Information
#
# Table name: service_offering_descriptions
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  clinic_id          :integer
#  college_health     :boolean
#  community_health   :boolean
#  family_planning    :boolean
#  planned_parenthood :boolean
#  private_practice   :boolean
#  std                :boolean
#  other              :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

class ServiceOfferingDescription < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  validate :ensure_some_service_offered

  def ensure_some_service_offered
    if [college_health,
        community_health,
        family_planning,
        other,
        planned_parenthood,
        private_practice,
        std].any?
      true
    else
      self.errors.add(:base, "you must specify some service!")
    end
  end
end