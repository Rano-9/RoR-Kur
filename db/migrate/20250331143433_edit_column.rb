class EditColumn < ActiveRecord::Migration[7.0]
  def change
    
    remove_column :memberships , :beer_club_id, :string
    remove_column :memberships , :user_id, :string
    
    add_column :memberships , :beer_club_id, :integer
    add_column :memberships , :user_id, :integer
        
  end
end
