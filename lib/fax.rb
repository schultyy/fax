require 'sinatra'
require 'json'
require 'sinatra/contrib'
require './lib/faxgeraet'

set :root, File.expand_path('../../', __FILE__)

before do
  @fax = Fax::Faxgeraet.new(nil)
end

get '/folders' do
   folders = @fax.fetch_folders
   json folders.map{|f| f.to_hash }
end

get '/:folder' do
  folder_name = params[:folder]
  folder_id = @fax.get_folder_id_by_name(folder_name)
  mails = @fax.show_folder_content(folder_id)
  json mails.map{ |m| m.to_hash }
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
