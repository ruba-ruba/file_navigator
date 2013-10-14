class Item < ActiveRecord::Base
  attr_accessible :references

  belongs_to :folder
end
