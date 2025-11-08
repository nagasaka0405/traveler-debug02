class RenameContentToMessageInMessages < ActiveRecord::Migration[7.1]
  def change
    rename_column :messages, :content, :message
  end
end
