require './couch_adapter'
require 'virtus'
require './mail_folder'

module Fax
  class Faxgeraet
    COUCH_DB = 'http://localhost:5984'
    DB = 'faxgeraet'
    def initialize(host, username, password)
      @couch = CouchAdapter.new(Faxgeraet::COUCH_DB, Faxgeraet::DB)
    end
    def fetch_folders
      result_set = @couch.query_view('folders', 'all', true)
      result_set['rows'].map {|f| Fax::MailFolder.new(f)}
    end
    def show_folder_content(folder_name)
    end
    def get_mail_by_id(folder_name, mail_id)
    end
  end
end
