class AddEmailToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :email, :string
    add_column :authors, :mobile, :string
  end
end
