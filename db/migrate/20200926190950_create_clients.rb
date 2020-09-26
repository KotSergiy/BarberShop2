class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |col|
      col.text :name
      col.text :phone
      col.text :datestamp
      col.text :barber
      col.text :color

      col.timestamps
    end
  end
end
