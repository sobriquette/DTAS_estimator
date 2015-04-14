class Project < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :people, dependent: :destroy
  belongs_to :owner, :class_name => 'Person'

  accepts_nested_attributes_for :tasks, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :people, :reject_if => :all_blank, :allow_destroy => true
  accepts_nested_attributes_for :owner, :reject_if => :all_blank
end
