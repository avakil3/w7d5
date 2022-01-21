class MakeSomeChange < ActiveRecord::Migration[5.2]
  def change
    add_column :subs, :user_id, :integer, null: false
  end
end
