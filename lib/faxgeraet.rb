require 'net/imap'
require 'virtus'
require 'mail'
require './lib/couch_adapter'
require './lib/mail_folder'
require './lib/email'

module Fax
  class Faxgeraet
    COUCH_DB = 'http://localhost:5984'
    DB = 'faxgeraet'
    def initialize(options)
      @options = options
      @couch = CouchAdapter.new(Faxgeraet::COUCH_DB, Faxgeraet::DB)
    end
    def fetch_folders
      result_set = @couch.query_view('folders', 'all') 
      result_set['rows'].map {|f| Fax::MailFolder.new(f['doc'])}
    end
    def get_folder_id_by_name(folder_name)
      params = { 'name' => folder_name, 'limit' => 1 }
      result_set = @couch.query_view_with_params('folders','by_name', params)
      result_set['rows'].map { |m| m['id'] }[0]
    end
    def show_folder_content(folder_id)
      result_set = @couch.query_view_with_param('mails','by_folder_id', folder_id)
      result_set['rows'].map {|m| Fax::Email.new(m['doc'])}
    end
    def get_mail_by_id(folder_name, mail_id)
    end
    def fetch_mails()
      imap = Net::IMAP.new(@options[:server], :port => 993, :ssl => true)
      imap.login(@options[:username], @options[:password])
      imap.examine('INBOX')
      imap.search(['NOT', 'SEEN']).each do |message_id|
        envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
        raw_body_text = imap.fetch(message_id,'BODY[TEXT]')[0].attr['BODY[TEXT]']
        body_text = Mail.new(raw_body_text).body
        mail = email_from_raw_data(envelope, body_text, '')
        @couch.save_mail(mail.to_hash(false))
      end
      imap.close()
    end
    private
    def email_from_raw_data(envelope, body_text, folder_id)
      from_mailbox = envelope.from[0].mailbox
      to_mailbox = envelope.to[0].mailbox

      from_host = envelope.from[0].host
      to_host = envelope.to[0].host
      from = "#{from_mailbox}@#{from_host}"
      to = "#{to_mailbox}@#{to_host}" 
      Fax::Email.from_data(envelope.message_id, from, to, envelope.subject,
                     body_text, folder_id)
    end
  end
end
