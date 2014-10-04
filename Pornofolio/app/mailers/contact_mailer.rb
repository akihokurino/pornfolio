class ContactMailer < ActionMailer::Base
  default from: 'tt.tanishi100@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.contact_mailer.send_mail_confirm.subject
  #
  def send_mail_confirm(data)
    @name = data[:name]
    @body = data[:body]

    address =  ['tt.tanishi100@gmail.com']
    address += ['hajiming@gmail.com', 'aki030402@gmail.com'] if Rails.env.production?
    mail(
      :subject => "Pornfolio お問い合わせ",
      :to      => address.join(',')
    )
  end
end
