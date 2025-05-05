class ScheduleEventsController < ApplicationController
  def create
    event = ScheduleEvent.new(schedule_event_params)

    if event.save
      flash[:notice] = 'Подію створено!'
      redirect_to profile_path(month: event.date.beginning_of_month.strftime('%Y-%m-01'))
    else
      flash[:alert] = event.errors.full_messages.join(', ')
      redirect_to profile_path
    end
  end

  def destroy
    event = ScheduleEvent.find(params[:id])
    event.destroy

    flash[:notice] = 'Подію видалено'
    redirect_to profile_path(month: event.date.beginning_of_month.strftime('%Y-%m-01'))
  end

  private

  def schedule_event_params
    params.require(:schedule_event).permit(:title, :date, :user_id)
  end
end
