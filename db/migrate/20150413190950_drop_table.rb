class DropTable < ActiveRecord::Migration
  def self.up
  	drop_table :project_tags
  end
end
