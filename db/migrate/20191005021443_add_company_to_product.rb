class AddCompanyToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :company, :string
  end
end
