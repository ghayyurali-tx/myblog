class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
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

end
