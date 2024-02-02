class CreateEventEnrolls < ActiveRecord::Migration[7.1]
  def change
    create_table :event_enrolls do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.boolean :present_at_event, default: false
      t.string :present_date
      t.string :present_time

      t.timestamps
    end
  end
end
