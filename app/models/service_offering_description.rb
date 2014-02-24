# == Schema Information
#
# Table name: service_offering_descriptions
#
#  id                                 :integer          not null, primary key
#  name                               :string(255)
#  clinic_id                          :integer
#  college_health                     :boolean
#  community_health                   :boolean
#  family_planning                    :boolean
#  planned_parenthood                 :boolean
#  private_practice                   :boolean
#  std                                :boolean
#  other                              :boolean
#  created_at                         :datetime
#  updated_at                         :datetime
#  charge_ct                          :string(255)
#  notify_test_ready                  :string(255)
#  deliver_results_online             :boolean
#  deliver_results_in_person          :boolean
#  deliver_results_on_phone_human     :boolean
#  deliver_results_on_phone_automated :boolean
#  deliver_results_other              :boolean
#

class ServiceOfferingDescription < ActiveRecord::Base
  belongs_to :clinic

  validates :name, presence: true
  validates :clinic, presence: true

  validate :ensure_some_service_offered

  CHARGE_CT_OPTIONS = ["Free", "Depends on the insurance", "Sliding scale", "Flat fee", "Other"]
  validates :charge_ct, inclusion: {in: CHARGE_CT_OPTIONS}, allow_nil: true

  NOTIFY_TEST_READY_OPTIONS = ["No", "Yes, for people who are positive", "Yes, for all patients", "Other"]
  validates :notify_test_ready, inclusion: {in: NOTIFY_TEST_READY_OPTIONS}, allow_nil: true

  def charge_ct_enum
    CHARGE_CT_OPTIONS
  end

  def notify_test_ready_enum
    NOTIFY_TEST_READY_OPTIONS
  end

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
