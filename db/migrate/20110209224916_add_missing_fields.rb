class AddMissingFields < ActiveRecord::Migration
  def self.up
    add_column :projects, :description, :string
    add_column :tasks,    :done,        :boolean
    add_column :tasks, :complexity, :integer, default: 1
    add_column :tasks, :est_time, :integer
    add_column :tasks, :actual_time, :integer
  end

  def self.down
  end
end
