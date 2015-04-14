class Task < ActiveRecord::Base
  has_many :sub_tasks, dependent: :destroy
  has_many :task_tags, dependent: :delete_all
  has_many :tags, :through => :task_tags, :class_name => 'Tag'


  accepts_nested_attributes_for :sub_tasks, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :task_tags, :allow_destroy => true

  enum complexity: { low: 1, medium: 2, high: 3 }

  # methods
  	def self.tagged_with
  		Tag.find_by_name!(:name).tasks
  	end

  	def self.average_time
		  average(:actual_time).where(self.tagged_with)
  	end
end
