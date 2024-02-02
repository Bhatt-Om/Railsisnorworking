class Event < ApplicationRecord
  
  def as_json(options = {})
    super(options).merge(
      date_list:  (Date.parse(starting_date)..Date.parse(ending_date)).to_a
    )
  end
end
