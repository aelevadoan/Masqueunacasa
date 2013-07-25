module HasLinks
  extend ActiveSupport::Concern

  included do
    has_many :links, as: :document, dependent: :destroy
    attr_accessible :links_attributes
    accepts_nested_attributes_for :links, allow_destroy: true,
      reject_if: proc { |attributes| attributes['title'].blank? && attributes['url'].blank? }
  end

  def add_link(link, user)
    link.document = self
    link.user = user
    link.save ? link : nil
  end

end
