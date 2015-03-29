class CreateSiteMaps < ActiveRecord::Migration
  def change
    create_table :site_maps do |t|
      t.string :url
      t.text :xml
      t.boolean :rendered
      t.boolean :failed, default: true
      t.timestamps null: false
    end
  end
end
