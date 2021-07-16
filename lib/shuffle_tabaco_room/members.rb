require "json"
require "date"

class ShuffleTabacoRoom::Members
  # "[
  #   {
  #     "name": "username",
  #     "availables": [
  #       "wed",
  #     ],
  #     "user_id": "slack user id",
  #   }
  # ]"
  MEMBERS = JSON.parse(ENV.fetch('MEMBERS'), symbolize_names: true)
  WDAYS = %w{sun mon tue wed thu fri sat}.freeze

  def shuffle
    today_available_memebrs.sample(2)
  end

  def today_available_memebrs
    MEMBERS.select{|x|
      x[:availables]
        .yield_self{|a| a.empty? || a.include?(today_wday) }
    }
  end

  def all_members
    MEMBERS
  end

  def today_wday
    @today_wday ||= WDAYS[today.wday]
  end

  def today
    @today ||= Date.today
  end
end
