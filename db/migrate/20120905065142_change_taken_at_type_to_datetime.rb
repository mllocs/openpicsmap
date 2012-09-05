class ChangeTakenAtTypeToDatetime < ActiveRecord::Migration
  
  def self.up
    change_table :pics do |t|
      t.change :taken_at, :datetime
    end
  end

  def self.down
    change_table :pics do |t|
      t.change :taken_at, :date
    end
  end
end
