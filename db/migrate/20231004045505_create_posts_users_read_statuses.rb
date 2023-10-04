class CreatePostsUsersReadStatuses < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_users_read_statuses do |t|
      t.boolean :read
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
