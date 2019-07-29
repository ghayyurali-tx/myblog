class Article < ApplicationRecord
  belongs_to :user
  validate :image_size_validation
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

end
