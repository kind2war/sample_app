class RenameTitelColumnToLists < ActiveRecord::Migration[6.1]
  def change
    # rename_column :テーブル名, :変更前のカラム名, :変更後のカラム名
    rename_column :lists, :titel, :title
  end
end
