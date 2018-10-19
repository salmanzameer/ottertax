class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
    	t.integer :year
    	t.integer :form_name
    	t.integer :user_id
    	t.integer :file_format
    	t.attachment :file
      t.timestamps
    end
  end
end
