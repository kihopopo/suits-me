class AddItemIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_reference :comments, :item, foreign_key: true
    add_reference :comments, :customer, foreign_key: true
    add_column :comments, :content, :string, null: false
  end
end
