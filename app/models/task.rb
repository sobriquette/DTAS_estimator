class Task < ActiveRecord::Base
  has_many :sub_tasks, dependent: :destroy
  has_many :task_tags, dependent: :delete_all
  has_many :tags, :through => :task_tags, :class_name => 'Tag'


  accepts_nested_attributes_for :sub_tasks, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :tags
  accepts_nested_attributes_for :task_tags, :allow_destroy => true

  enum complexity: { low: 1, medium: 2, high: 3 }

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
    
  def self.tagged_with
  	Tag.find_by_name!(:name).tasks
  end

	def self.average_time
	  @avg = average(:actual_time).where(self.tagged_with)
	  return @avg
	end
  	
	def calculate_est_time
    @avg = self.average_time
    @est_time = @avg * self.complexity
    return @est_time
	end
  	
	def display_est_time
	  self.tagged_with ? calculate_est_time : '1'
	end
  
  private
    def check_task_tags
      if self.task_tags.size < 1 || self.task_tags.all? {|task_tags| task_tags.marked_for_destruction? }
      errors.add(:base, "Please add a category.")
      end
    end
end
