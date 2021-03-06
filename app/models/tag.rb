class Tag < ActiveRecord::Base
	has_many :task_tags
	has_many :tasks, :through => :task_tags

	accepts_nested_attributes_for :task_tags, :allow_destroy => true

	validates_presence_of :name, length: { maximum: 50 }


	def self.est_time(tag_id)
		# actual_time_bool_blank = Tag.joins(:tasks).where("tags.name in (?) ", tag_id).where("actual_time").blank?
		actual_time_bool_other = Tag.joins(:tasks)
									.where("tags.name in (?) ", tag_id)
									.where("actual_time IS NOT NULL")
									.where("actual_time <> 0")
		if Tag.where("tags.name in (?) ", tag_id).any? && (actual_time_bool_other.any?)
  			avg = Tag.joins(:tasks).where("tags.name in (?) ", tag_id ).average("actual_time")
  		else
  			avg = 16
  		end
  		return avg
	end
end
