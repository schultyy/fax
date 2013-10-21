module Fax
  class MailFolder
    include Virtus.model
    attribute :name, String
    attribute :_id, String
    def to_hash
      {
        :_id => @_id,
        :name => @name
      }
    end
  end
end
