require 'factory_girl'
require './lib/email'

FactoryGirl.define do
  factory :mail, class: Fax::Email do
    _id '432423'
    from 'john@example.com'
    to 'jim@example.com'
    subject 'Your advertisement here'
    body 'Ad Ad Ad Ad Ad Ad Ad Ad'
    folder_id '1'
    message_id '4234324324@example.com'
  end
end
