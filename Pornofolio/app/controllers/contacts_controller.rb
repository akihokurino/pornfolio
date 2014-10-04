class ContactsController < ApplicationController
  resource_description { resource_id @controller.try(:controller_path) || controller_path }
  include Doc::Contacts

  def create
    mail = ContactMailer.send_mail_confirm(create_mail_params)
    mail.deliver
  end

  private
  def create_mail_params
    params.require(:contact).permit(:name, :body)
  end
end
