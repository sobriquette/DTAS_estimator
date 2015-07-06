class Tag < ActiveRecord::Base
	has_many :task_tags
	has_many :tasks, :through => :task_tags

	accepts_nested_attributes_for :task_tags, :allow_destroy => true


	def self.est_time(tag_id)
		if Tag.where("tags.name = ? ", tag_id).any?
  			avg = Tag.joins(:tasks).where("tags.name = ? ", tag_id ).average("actual_time")
  		else
  			avg = 1
  		end
  		return avg
	end
end
