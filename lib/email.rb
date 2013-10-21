module Fax
  class Email
    include Virtus.model
    attribute :_id, String
    attribute :from, String
    attribute :to, String
    attribute :subject, String
    attribute :body, String
    attribute :folder_id, String
    def to_hash
      {
        :_id => @_id,
        :from => @from,
        :to => @to,
        :subject => @subject,
        :body => @body,
        :folder_id => @folder_id
      }
    end
  end
end
