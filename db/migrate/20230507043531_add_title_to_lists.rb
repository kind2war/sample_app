class AddTitleToLists < ActiveRecord::Migration[6.1]
  def change
    add_column :lists, :titel, :string
  end
end
