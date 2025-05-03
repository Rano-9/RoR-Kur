class Changecolumn < ActiveRecord::Migration[7.0]
  change_table :styles do |s|
    s.rename :type, :description
  end
  def change
    change_column :styles, :description, :text
  end

end
