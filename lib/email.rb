module Fax
  class Email
    include Virtus.model
    attribute :_id, String
    attribute :from, String
    attribute :to, String
    attribute :subject, String
    attribute :body, String
    attribute :folder_id, String
    attribute :message_id, String
    def self.from_data(message_id = '', from = '', to = '', subject = '', body = '', folder_id = '')
      mail = Fax::Email.new
      mail.message_id = message_id
      mail.from = from
      mail.to = to
      mail.subject = subject
      mail.body = body
      mail.folder_id = folder_id
      mail
    end 
    def to_hash(with_id)
      hash = {
        :from => @from,
        :to => @to,
        :subject => @subject,
        :body => @body,
        :folder_id => @folder_id,
        :type => 'mail',
        :message_id => @message_id
      }
      hash[:_id] = @_id if with_id
      hash
    end
  end
end
