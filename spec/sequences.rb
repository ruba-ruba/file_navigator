FactoryGirl.define do

  sequence :folder do |n| 
    "title#{n}"
  end

  sequence :item_name do |n|
    "item_name#{n}"
  end
  
end