class AddSsnCodetoUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :ssn_code_id, :integer
  end
end
