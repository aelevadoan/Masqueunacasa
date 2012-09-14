class Category < ActiveRecord::Base
  include Translatable
  extend FriendlyId
  friendly_id :name, use: :simple_i18n
  acts_as_list scope: :phase_id
  has_paper_trail meta: {title: :title}
  mount_uploader :image, CategoryImageUploader

  translates :name, :slug, :title, :summary, :body
  translation_required :title, :slug, :name

  attr_accessible :name, :title, :summary, :body, :body_type
  attr_accessible :user_id, :user, :phase_id, :phase
  attr_accessible :image, :remove_image

  validates_presence_of :user_id, :phase_id, :title, :name

  belongs_to :user
  belongs_to :phase, touch: true
  has_many :proposals, order: :position

  include HasSections
  include HasEditors
  include HasPopularity
  include HasSubscriptors

  after_save :propagate_phases

  private
  def propagate_phases
    if phase_id_changed?
      self.proposals.each(&:save)
    end
  end
end
