class Tag < ActiveRecord::Base
	has_many :task_tags
	has_many :tasks, :through => :task_tags

	accepts_nested_attributes_for :task_tags, :allow_destroy => true

	validates_presence_of :name, length: { maximum: 50 }


	def self.est_time(tag_id)
		if Tag.where("tags.name in (?) ", tag_id).any? && !(Tag.joins(:tasks).where("tags.name in (?) ", tag_id ).where("actual_time is NULL OR actual_time IN ('0','')"))
  			avg = Tag.joins(:tasks).where("tags.name in (?) ", tag_id ).average("actual_time")
  		else
  			avg = 16
  		end
  		return avg
	end
end
