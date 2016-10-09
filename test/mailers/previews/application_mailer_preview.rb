class ApplicationMailerPreview < ActionMailer::Preview
  def sample_mail_preview
    ApplicationMailer.sample_email(User.first)
  end
end

def sample_email(user)
  mg_client = Mailgun::Client.new 'key-7491691eb04bbcfd1432885401bc4010'
  message_params = {:from    => 'kobzarvs@gmail.com',
                    :to      => 'kobzarvs@yandex.ru',
                    :subject => 'Sample Mail using Mailgun API',
                    :text    => 'This mail is sent using Mailgun API via mailgun-ruby'}
  mg_client.send_message 'sandbox2aaa83b400be4b788a56f124b7cc7673.mailgun.org', message_params
end