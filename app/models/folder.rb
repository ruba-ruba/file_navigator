class Folder < ActiveRecord::Base
  attr_accessible :title, :parent_id, :parent, :ancestry

  has_ancestry

  has_many :items, dependent: :destroy
  has_many :comments, :as => :commentable, dependent: :destroy

  belongs_to :user

  validates :title, presence: true
  validates_uniqueness_of :title, :scope => :ancestry

  accepts_nested_attributes_for :items, allow_destroy: true

  def path
    if self.parent.nil?
      nil
    else
      result = []
      folder = self.parent
      while folder do
        result << folder.title
        folder = folder.parent
      end
      result.reverse.join("/")
    end
  end
end

