class Image < ActiveRecord::Base
  attr_accessible :title,
                  :image,
                  :image_cache,
                  :external_image_url,
                  :credits,
                  :new_object
  delegate :title, to: :imageable, prefix: true

  validate :image_xor_external_image_url

  default_scope order: 'position ASC'
  belongs_to :user
  belongs_to :imageable, polymorphic: true

  acts_as_list scope: [:imageable_type, :imageable_id]
  mount_uploader :image, ImageUploader

  def new_object
    new_record?
  end

  def new_object=(value)
    nil
  end

  private
  def image_xor_external_image_url
    if (self.image.blank? && self.external_image_url.blank?)
      errors.add(:image, "Debes introducir al menos una fuente para la imagen")
    end
    if (!self.image.blank? && !self.external_image_url.blank?)
      errors.add(:image, "No puedes introducir dos fuentes para la imagen")
    end
  end
end
