class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :created_by
      t.integer :updated_by
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
