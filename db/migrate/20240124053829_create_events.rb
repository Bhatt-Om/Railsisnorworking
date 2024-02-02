class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.text :discription
      t.string :starting_date, default: ''
      t.string :ending_date, default: ''

      t.timestamps
    end
  end
end
