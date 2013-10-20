require 'sinatra'
require 'sinatra/contrib'
require 'fax_geraet'

get '/folders' do
  json fetch_folders
end

get '/:folder' do
  folder_name = params[:folder]
  json show_folder_content(folder_name)
end

get '/:folder/mail/:id' do
  folder_name = params[:folder]
  mail_id = params[:id]
  json get_mail_by_id(folder_name, mail_id)
end

post '/sendmail' do
    # not implemented. Who actually wants to write mails?
end
