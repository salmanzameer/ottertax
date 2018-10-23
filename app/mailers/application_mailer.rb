class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def send_document(document)
  	attachments[document.filename] = {:mime_type => document.content_type,
                                   :content => document.file_contents }
    mail(:to => document.user.email, :subject => "New account information")
  end
end
