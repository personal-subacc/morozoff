class Address < ApplicationRecord
  belongs_to :end_user
  # has_many :orders

  VALID_POSTAL_CODE_REGEX = /\A\d{3}[-]?\d{4}\z/
  validates :postal_code, format: { with: VALID_POSTAL_CODE_REGEX }

  validates :address, length: { minimum: 10, maximum: 100 }
  validates :name, :postal_code, :address, presence: true

  def full_address
    postal_code + address + name
  end
end