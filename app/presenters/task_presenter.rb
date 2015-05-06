class TaskPresenter < BasePresenter
   presents :task
   
   # Methods for calculating and displaying estimated time
   def display_est_time
      task.tagged_with ? calculate_est_time : '1'
   end
   
   def self.tagged_with
  		Tag.find_by_name!(:name).tasks
   end

  	def self.average_time
		@avg = average(:actual_time).where(self..tagged_with)
		return @avg
  	end
  	
  	def calculate_est_time
  	  @avg = self.average_time
  	  @est_time = @avg * task.complexity
  	  return @est_time
  	end
   
end