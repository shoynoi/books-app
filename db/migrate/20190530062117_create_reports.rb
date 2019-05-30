class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :title, null: false, limit: 100
      t.text :description
      t.date :reported_on

      t.timestamps
    end
  end
end
