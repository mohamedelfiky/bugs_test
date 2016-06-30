class CreateBugs < ActiveRecord::Migration
  def change
    create_table :bugs do |t|
      t.string :application_token
      t.integer :number
      t.integer :status
      t.integer :priority

      t.timestamps null: false
    end

    add_index :bugs, :application_token, using: :btree
    add_index :bugs, :number, using: :btree
    add_index :bugs, %i(application_token number), unique: true, using: :btree
  end
end
