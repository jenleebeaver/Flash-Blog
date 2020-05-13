class Blogposts < ActiveRecord::Migration
  def change
      create_table :blogposts do |t|
        t.string :content
        t.integer :user_id
    end
  end
end
