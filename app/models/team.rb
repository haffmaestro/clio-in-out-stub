class Team < ActiveRecord::Base
  has_many :users, dependent: :nullify

  validates :name, presence: true
end
