class Task < ActiveRecord::Base
  has_many :sub_tasks
  has_many :task_tags
  has_many :tags, :through => :task_tags, :class_name => 'Tag'


  accepts_nested_attributes_for :sub_tasks, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :task_tags, :allow_destroy => true
end
