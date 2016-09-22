class Event < ApplicationRecord
	belongs_to :user,  :foreign_key => :owner_id
	has_many :event_users
	has_many :users, :through => :event_users

	validates :name, presence: true
	validates :date, presence: true
	validates :max_participants, presence: true

	validate :cannot_have_more_participants_than_max
	validate :cannot_be_before_now
	private

		def cannot_have_more_participants_than_max
			if max_participants < users.length
				errors.add(:max_participants, "cannot be less than current number of participants")
			end
		end

		def cannot_be_before_now
			if date <= DateTime.now
				errors.add(:date, "Event's date cannot be set before now")
			end
		end
end
