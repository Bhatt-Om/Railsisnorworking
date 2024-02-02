class AddColummnEntollDateToEventEnrolls < ActiveRecord::Migration[7.1]
  def change
    add_column :event_enrolls, :enroll_date, :text
    add_column :event_enrolls, :present_dates, :text
  end
end
