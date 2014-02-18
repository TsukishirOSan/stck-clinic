class Contact < ActiveRecord::Base
  belongs_to :clinic
  
  validates :clinic, presence: true
  validates :email, presence: true
  validates :name, presence: true
  validates :phone, presence: true
end
