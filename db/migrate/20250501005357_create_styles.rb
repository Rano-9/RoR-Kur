class CreateStyles < ActiveRecord::Migration[7.0]
  def change
    create_table :styles do |t|
      t.string :name
      t.text :type

      t.timestamps
    end
  end
end
