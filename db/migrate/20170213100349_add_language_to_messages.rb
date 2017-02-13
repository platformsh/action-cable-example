class AddLanguageToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :language, :string
  end
end
