class Email < ActiveRecord::Base
  attr_accessible :address, :document_id, :message
  belongs_to :document
  
end
