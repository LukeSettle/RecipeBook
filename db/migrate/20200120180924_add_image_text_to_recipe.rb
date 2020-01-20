class AddImageTextToRecipe < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :image_text, :text
  end
end
