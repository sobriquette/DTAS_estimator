class AddIndexToTaskTags < ActiveRecord::Migration
  def change
  	add_index :task_tags, :task_id
  	add_index :task_tags, :tag_id
  end
end
