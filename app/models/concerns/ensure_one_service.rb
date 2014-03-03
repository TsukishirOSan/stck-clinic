require 'active_support/concern'

# Concern used for a series of booleans in which at least one must
# have a truthy value.
module EnsureOneService
  extend ActiveSupport::Concern

  included do
    validate :ensure_some_service_offered
  end

  def ensure_some_service_offered
    if [college_health, community_health,
        family_planning, other,
        planned_parenthood, private_practice,
        std].any?
      true
    else
      errors.add(:base, 'you must specify some service!')
    end
  end
end
