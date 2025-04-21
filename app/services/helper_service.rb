
module HelperService
  extend ActionView::Helpers::DateHelper
  module_function

  def human_time_difference(from_time, to_time)
    seconds = (to_time - from_time).to_i
    return 'менше хвилини' if seconds < 60

    minutes = seconds / 60
    hours = minutes / 60
    days = hours / 24

    parts = []
    parts << "#{days} днів" if days > 0
    parts << "#{hours % 24} годин" if hours % 24 > 0
    parts << "#{minutes % 60} хвилин" if minutes % 60 > 0

    parts.join(' ')
  end
end