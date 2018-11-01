class AddCompanyNameToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :company_name, :string
  end
end
