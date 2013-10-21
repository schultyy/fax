require 'sinatra'
require 'sinatra/contrib'
require './lib/faxgeraet'

set :root, File.expand_path('../../', __FILE__)

before do
  @fax = Fax::Faxgeraet.new(nil, nil, nil)
end

get '/folders' do
  json @fax.fetch_folders
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

post '/sendmail' do
    # not implemented. Who actually wants to write mails?
end
