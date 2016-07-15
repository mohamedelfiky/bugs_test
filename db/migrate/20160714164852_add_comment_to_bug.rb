class AddCommentToBug < ActiveRecord::Migration
  def change
    add_column :bugs, :comment, :text
  end
end
