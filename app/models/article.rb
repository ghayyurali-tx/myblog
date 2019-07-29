class Article < ApplicationRecord
  belongs_to :user
  validate :image_size_validation
  validate :validate_minimum_image_size
  include CarrierWave::Validations::ActiveModel
  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title,
            length: { minimum: 5 }


def self.search(search)
  #debugger
if search
  Article.where("lower(title) LIKE ?","%#{search.downcase}%")
#   # debugger
#   # if article
#   #   article
  else
    Article.all
  end
# else
#   Article.all
#
# end
end

  private

  def image_size_validation
    errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
  end

  def validate_minimum_image_size
    # image = MiniMagick::Image.open(image.path)

      errors[:image] << "should be greater than or equal to 720x550"  if image.width < 720 && image.height < 550

    end

end
