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
  		
  		# average actual times
  		avg = Task.joins(:tags).where("tags.name = ? ", self.tags.first.name ).average("actual_time")
  		# calculate est time based on complexity selected
  		est_time = avg * self[:complexity]
  		return est_time
	end

	private

  	def check_task_tags
  		if self.task_tags.size < 1 || self.task_tags.all? {|task_tags| task_tags.marked_for_destruction? }
			errors.add(:base, "Please select a tag.")
		end
  	end

end
