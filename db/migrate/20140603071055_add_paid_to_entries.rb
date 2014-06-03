class AddPaidToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :paid, :boolean
  end
end
