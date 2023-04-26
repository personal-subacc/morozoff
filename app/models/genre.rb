class Genre < ApplicationRecord
  has_many :items, dependent: :destroy
  validates :name, presence: true

  def self.search(search)
    if search
      Genre.where(['name LIKE ?', "%#{search}%"])
    else
      Genre.all
    end
  end
end