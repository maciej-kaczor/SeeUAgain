class User < ApplicationRecord
	require 'digest/sha1'
	#before_save :encrypt_password
	has_secure_password
	
	has_many :events, :foreign_key => :owner_id
	has_many :event_users
	has_many :events, :through => :event_users

	validates :email, presence: true, :uniqueness => true
	validates :first_name, presence: true
	validates :last_name, presence: true


end
