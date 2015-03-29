class CreateSiteMaps < ActiveRecord::Migration
  def change
    create_table :site_maps do |t|
      t.string :url
      t.text :xml
      t.boolean :rendered, default: false
      t.boolean :failed, default: false
      t.timestamps null: false
    end
  end
end
