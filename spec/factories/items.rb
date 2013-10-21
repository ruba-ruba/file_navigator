# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    association :folder, :factory => :folder
    item_file_name {generate(:item_name)}
    item_content_type "application/x-msdownload"
    item_file_size "7766"
    item_updated_at "#{Time.now}"
  end

  factory :file_item, :class => 'Item' do
    item File.open(Rails.root + 'spec/factories/test.csv')
  end
end
