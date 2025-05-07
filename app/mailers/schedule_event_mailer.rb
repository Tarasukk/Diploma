class ScheduleEventMailer < ApplicationMailer
  def remind_about_event_email(user, events)
    @user = user
    @events = events

    mail(to: @user.email, subject: 'Нагадування про завтрашні події')
  end
end
