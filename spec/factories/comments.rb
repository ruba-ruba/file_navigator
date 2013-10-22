# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :folder_comment, :class => 'Comment' do
    content "comment for something"
    association :commentable, :factory => :folder
    #comment.commentable { |a| a.association(:folder) }
  end

  factory :item_comment, :class => 'Comment' do 
    content "comment for something"
    association :commentable, :factory => :item
  end
end
