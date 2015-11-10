class Task < ActiveRecord::Base
	has_many :sub_tasks, dependent: :destroy
	has_many :task_tags, dependent: :delete_all
	has_many :tags, :through => :task_tags, :class_name => 'Tag'

	accepts_nested_attributes_for :sub_tasks, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :tags, reject_if: :all_blank
	accepts_nested_attributes_for :task_tags, :allow_destroy => true

	enum complexity: { low:1, medium: 2, high: 3 }

	#validations 
	validates_presence_of :name, :description, :complexity
	validates :name, length: { maximum: 50 }
	validates :description, length: { maximum: 140 }

=begin
	validates :actual_time, numericality: { :greater_than_or_equal_to => 0, 
										  :less_than_or_equal_to => 100 }, 
									   	  format: { :with => /\A\d+(?:\.\d{0,1})?\z/, 
									   	  message: "accepts only decimals to nearest tenth" }
=end
	validate :check_task_tags
	
	def est_time
  		# avg = Task.find_by_sql("SELECT AVG(tasks.actual_time * tasks.complexity) FROM tasks INNER JOIN task_tags 
  		# 	  									ON task_tags.task_id = tasks.id INNER JOIN tags 
  		# 	  									ON tags.id = task_tags.tag_id WHERE tags.name = 'Navigation'")
		min_est_time = 16
		#null_tag_bool = Task.joins(:tags).where("tags.name in (?)", self.tags.first.name).where("actual_time").blank?
		# count_tags = Task.joins(:tags).where("tags.name in (?)", self.tags.first.name).count
		# null_tag_bool_other = Task.joins(:tags).where("tags.name in (?)", self.tags.first.name).try("actual_time")
  		if self.tags.exists? && 
  			(Task.joins(:tags).where("tags.name in (?)", self.tags.first.name).count > 0) && 
  			!(Task.joins(:tags).where("tags.name in (?)", self.tags.first.name).try("actual_time"))
  			
  			puts "actual_time for this task: #{self.actual_time}"
  			puts "complexity for this task: #{self.complexity}"
	  		# average actual times
	  		avg = Task.joins(:tags).where("tags.name = ? ", self.tags.first.name ).where("actual_time IS NOT NULL").average("actual_time")
	  		puts "avg for this #{self.name} is #{avg}"
	  		if avg.nil?
	  			est_time = min_est_time * self[:complexity]
	  		else
		  		# calculate est time based on complexity selected
		  		est_time = avg * self[:complexity]
		  	end
	  	else
	  		est_time = min_est_time * self[:complexity]
	  	end
  		return est_time
	end

	private

  	def check_task_tags
  		if self.task_tags.size < 1 || self.task_tags.all? {|task_tags| task_tags.marked_for_destruction? }
			errors.add(:base, "Please select a tag.")
		end
  	end

end
