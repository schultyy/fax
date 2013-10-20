module Fax
  class Email
    include Virtus.model
    attribute :_id, String
    attribute :from, String
    attribute :to, String
    attribute :subject, String
    attribute :body, String
    attribute :folder_id, String
  end
end
