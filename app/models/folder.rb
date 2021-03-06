class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry, :folder, :description

  attr_accessor :folder

  has_ancestry

  has_many :items, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  belongs_to :user

  validates :title, presence: true
  validates_uniqueness_of :title, :scope => :ancestry

  accepts_nested_attributes_for :items, allow_destroy: true

  def path(root = nil)
    if self.parent.nil?
      nil
    else
      #binding.pry
      result = []
      folder = self.parent
      while folder != nil
        result << folder.title
        folder = folder == root ? nil : folder.parent
      end
      result.reverse.join("/")
    end
  end

end

