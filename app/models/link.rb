class Link < ActiveRecord::Base
  attr_accessible :title, :url

  belongs_to :user
  belongs_to :resource, polymorphic: true
  delegate :title, to: :resource, prefix: true

  validates :title, presence: true
  validates :url, presence: true
  #validates :content_type, presence: true

  before_validation :complete_title
  before_validation :set_content_type

  has_paper_trail meta: { title: :title, parent_title: :resource_title, document: :resource}

  private
  def complete_title
    self.title ||= self.url
  end

  def set_content_type
    if self.url =~ /youtube/ 
      self.content_type = 'video'
    else
      self.content_type = 'link'
    end
  end
end
