class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.string :data, array:true, default: []
      t.timestamps
    end
  end
end
