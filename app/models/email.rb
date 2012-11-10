class Email < ActiveRecord::Base
  attr_accessible :address, :document_id
  belongs_to :document
  
end
