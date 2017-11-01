class MakeReviewsAJoinTable < ActiveRecord::Migration[5.1]
  def up
    Review.delete_all
    remove_column :reviews, :name
    add_column :reviews, :user_id, :integer
  end

  def down
    Review.delete_all
    remove_column :reviews, :user_id
    add_column :reviews, :name, :string
  end
end
