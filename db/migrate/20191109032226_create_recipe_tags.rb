class CreateRecipeTags < ActiveRecord::Migration[5.2]
  def change
    create_table :recipe_tags do |t|
      t.references :tag
      t.references :recipe

      t.timestamps
    end
  end
end
