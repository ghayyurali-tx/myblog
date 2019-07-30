class Article < ApplicationRecord
  belongs_to :user
  # validate :image_size_validation
  # validate :validate_minimum_image_size
  # include CarrierWave::Validations::ActiveModel
  # mount_uploader :image, ImageUploader
  # validate :image_type
  has_one_attached :image

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title,
            length: { minimum: 5 }

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
            dimension: { width: { min: 720, max: 1920 },
                         height: { min: 520, max: 1080 }, message: 'is not given between dimension. Please Provide image with dimensions between [720-1920]x[550-1080]' }


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

  # private
  #
  # def image_type
  #   if image.attached? == false
  #     errors.add(:image, "is missing!")
  #   end
  #   if !image.content_type.in?(%('image/jpeg image/png'))
  #     errors.add(:image, "needs to be a jpeg or png!")
  #   end
  #
  # end

  # private
  #
  # def image_size_validation
  #   errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
  # end

  # def validate_minimum_image_size
  #   # image = MiniMagick::Image.open(image.path)
  #
  #     errors[:image] << "should be greater than or equal to 720x550"  if image.width < 720 && image.height < 550
  #
  #   end

end
