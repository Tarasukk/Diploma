require 'sidekiq-scheduler'

class SendEventNotificationWorker
  include Sidekiq::Job

  sidekiq_options queue: :scheduler

  def perform
    User.all.each do |user|
      events = ScheduleEvent.where(date: Date.tomorrow)
        .where(ScheduleEvent.arel_table[:user_id].eq(user.id).or(ScheduleEvent.arel_table[:student_group_id].eq(user.student_group_id))
      )

      next if events.blank?

      ScheduleEventMailer.remind_about_event_email(user, events).deliver_now
    end
  end
end
