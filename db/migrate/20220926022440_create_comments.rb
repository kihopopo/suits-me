class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.float :rate

      t.timestamps
    end
  end
end
