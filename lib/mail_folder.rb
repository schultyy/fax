module Fax
  class MailFolder
    include Virtus.model
    attribute :name, String
    attribute :id, String
  end
end
