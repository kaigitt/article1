class RenameUserImageColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :user_image, :profile_image
  end
end
