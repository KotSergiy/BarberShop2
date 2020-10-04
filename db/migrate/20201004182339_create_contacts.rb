class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |col|
      col.text :mail
      col.text :message

      col.timestamps
    end
  end
end
