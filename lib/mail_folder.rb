module Fax
  class MailFolder
    include Virtus.model
    attribute :name, String
    attribute :_id, String
  end
end
