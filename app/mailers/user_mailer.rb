class UserMailer < ApplicationMailer

	def welcome_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end

	def new_event_email(user, event)
		@user = user
		@event = event
		@owner = User.find(@event.owner_id)
		mail(to: @user.email, subject: 'New event created!')
	end
end
