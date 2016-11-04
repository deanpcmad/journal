class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.belongs_to :entry, foreign_key: true
      t.string :file
      t.string :name
      t.integer :size
      t.string :extension

      t.timestamps
    end
  end
end
