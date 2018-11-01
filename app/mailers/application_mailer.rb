class ApplicationMailer < ActionMailer::Base
  default from: 'support@ottertax.com'
  layout 'mailer'

  def send_document(document, email)
  	data = document.decrypt_file
  	attachments[document.filename] = { mime_type: document.content_type, content: data }
    mail(to: email, subject: "Tax information file")
  end
end
