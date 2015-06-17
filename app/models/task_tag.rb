class TaskTag < ActiveRecord::Base
	belongs_to :tag
	belongs_to :task

	# validates_presence_of :tag
	# validates_presence_of :task

	accepts_nested_attributes_for :tag, :reject_if => :all_blank
	#accepts_nested_attributes_for :task, :reject_if => :all_blank

	def remove_orphaned
		TaskTag.where([
			"task_id NOT IN (?) OR task_id NOT IN (?)",
			Task.pluck("id"),
			Tag.pluck("id")
		]).destroy_all
	end
end
