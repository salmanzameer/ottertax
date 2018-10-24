class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def send_document(document)
  	data = document.decrypt_file
  	attachments[document.filename] = { mime_type: document.content_type, content: data }
    mail(to: document.user.email, subject: "Tax information file")
  end
end
