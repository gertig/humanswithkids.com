class CreateGrumps < ActiveRecord::Migration
  def change
    create_table :grumps do |t|
      t.string :name
      t.date :published_at

      t.timestamps
    end
  end
end
