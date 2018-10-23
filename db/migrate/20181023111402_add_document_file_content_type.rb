class AddDocumentFileContentType < ActiveRecord::Migration[5.2]
  def change
  	add_column :documents, :filename, :string
  	add_column :documents, :content_type, :string
  	add_column :documents, :file_contents, :binary
  end
end
