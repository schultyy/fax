require 'sinatra'
require 'json'
require 'sinatra/contrib'
require './lib/faxgeraet'

set :root, File.expand_path('../../', __FILE__)

before do
  credentials = JSON.parse(File.read('credentials.json'))
  @fax = Fax::Faxgeraet.new(credentials)
end

get '/' do
  json "hello"
end

get '/folders' do
   folders = @fax.fetch_folders
   json folders.map{|f| f.to_hash }
end

get '/:folder' do
  folder_name = params[:folder]
  json @fax.show_folder_content(folder_name)
end

get '/:folder/mail/:id' do
  folder_name = params[:folder]
  mail_id = params[:id]
  json @fax.get_mail_by_id(folder_name, mail_id)
end

post '/fetchmails' do

end

post '/sendmail' do
    # not implemented. Who actually wants to write mails?
end
