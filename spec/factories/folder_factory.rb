require 'factory_girl'
require './lib/mail_folder.rb'

FactoryGirl.define do
  factory :folder, class: Fax::MailFolder do 
    name 'folder'
    _id '432423'
  end
end
