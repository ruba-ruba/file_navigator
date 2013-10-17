FactoryGirl.define do
  sequence :folder do |n| 
    "title#{n}"
  end
end