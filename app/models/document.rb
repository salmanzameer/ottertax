class Document < ApplicationRecord

	belongs_to :user
	
	# has_attached_file :file
	# validates_attachment_presence :file
	# validates_attachment_content_type :file, content_type: [ "application/pdf", "application/x-pdf", "application/octet-stream", "application/x-download" ]
	
	def uploaded_file=(incoming_file)
		self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.file_contents = encrypt_file(incoming_file.read)
  end

  def filename=(new_filename)
  	write_attribute("filename", sanitize_filename(new_filename))
  end
	
	class FormName
		B1095 = 1
		C1095 = 2
		INT1099 = 3
		MISC1099 = 4
		R1099 = 5
		W2 = 6
		W2C = 7

		NAMES = { B1095 => "1095-B", C1095 => "1095-C", INT1099 => "1099-INT",  MISC1099 => "1099-MISC",  R1099 => "1099-R", W2 => "W-2", W2C => "W-2c" }

		def self.for_select
      NAMES.invert.to_a
    end
	end

	class FileFormat
		MICEXCEL = 1
		OFFICE = 2
		CSV = 3
		TRANSFILE = 4

		NAMES = { MICEXCEL => "Microsoft Excel", OFFICE => "OpenOffice/LibreOffice", CSV => "Comma-separated value (CSV)",  TRANSFILE => "IRS/SSA transmission file" }

		def self.for_select
      NAMES.invert.to_a
    end
	end

	def encrypt_file(data)
  	encrypt(data)
  end

	def decrypt_file
  	decrypt(file_contents)
  end

	private
  
  def encrypt(data)
  	cryptor = Cryptor::SymmetricEncryption.new(ENV['OT-SECRET-KEY'])
  	ciphertext = cryptor.encrypt(data)
  	return 	ciphertext
  end

  def decrypt(data)
  	cryptor = Cryptor::SymmetricEncryption.new(ENV['OT-SECRET-KEY'])
  	decrypted = cryptor.decrypt(data)
  	return 	decrypted
  end

  def sanitize_filename(filename)
  	just_filename = File.basename(filename)
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
