require 'kobza_crm/version'

require 'kobza_crm/domain/person'
require 'kobza_crm/domain/organization'

require 'kobza_crm/infrastructure/persistence/memory/party_repository'

require 'kobza_crm/service/add_email_address_transaction'
require 'kobza_crm/service/add_web_page_address_transaction'
require 'kobza_crm/service/add_person_transaction'
require 'kobza_crm/service/add_organization_transaction'
require 'kobza_crm/service/make_person_a_customer_transaction'
require 'kobza_crm/service/make_person_a_customer_service_representative_transaction'
require 'kobza_crm/service/open_service_case_transaction'

module KobzaCRM
  # Your code goes here...
end
