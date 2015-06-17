class Project < ActiveRecord::Base
	has_many :tasks, dependent: :destroy
	has_many :people, dependent: :destroy
	belongs_to :owner, class_name: 'Person'

	accepts_nested_attributes_for :tasks, reject_if: :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :people, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for :owner, :reject_if => :all_blank

	#validations and input conversion
	before_save { name = String(name).downcase}
	validates :name, presence: true, uniqueness: { case_sensitive: false }
	validate :check_tasks

	private
		def check_tasks
			if self.tasks.size < 1 || self.tasks.all? {|tasks| tasks.marked_for_destruction? }
			errors.add(:base, "Project must have at least one task.")
		end
	end
end
