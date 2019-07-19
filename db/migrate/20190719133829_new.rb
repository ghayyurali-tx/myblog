class New < ActiveRecord::Migration[5.1]
  def change

    add_foreign_key :comments, :users
  end
end
