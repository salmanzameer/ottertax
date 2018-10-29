class ChangeSsnCodeColumnCodeType < ActiveRecord::Migration[5.2]
  def change
  	change_column :ssn_codes, :code, :string
  end
end
