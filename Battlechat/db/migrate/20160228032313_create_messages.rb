class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.text :author
      t.text :authorid
      t.text :image

      t.timestamps
    end
  end
end
