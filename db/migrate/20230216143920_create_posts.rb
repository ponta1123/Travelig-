class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false           #投稿タイトル
      t.text :introduction, null: false      #紹介文
      t.integer :user_id, null: false        #ユーザーID
      t.integer :tag_id                      #ブックマークID
      t.text :tourist_spot                   #観光地住所
      t.timestamps
    end
  end
end
