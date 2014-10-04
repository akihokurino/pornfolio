Apipie.configure do |config|
  config.app_name                = "Pornofolio"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.markup                  = Apipie::Markup::Markdown.new
  # were is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/*.rb"
end
