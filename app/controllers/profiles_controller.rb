class ProfilesController < ApplicationController
  def show
    @user = current_user
    @student_group = @user.student_group

    @current_month = params[:month] ? Date.parse(params[:month]) : Date.today.beginning_of_month

    start_date = @current_month.beginning_of_month.beginning_of_week(:monday)
    end_date = @current_month.end_of_month.end_of_week(:monday)

    events_scope = ScheduleEvent.arel_table

    @events = ScheduleEvent
      .where(date: start_date..end_date)
      .where(
        events_scope[:student_group_id].eq(current_user.student_group_id)
        .or(events_scope[:user_id].eq(current_user.id))
      )
      .includes(:course)
      .group_by(&:date)
  end
end
