class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true
  validates :username, length: { minimum: 3 }
  validates :username, length: { maximum: 30 }
  validates :password, length: {minimum: 4}

  has_many :ratings
  has_many :memberships
  has_many :beer_clubs, through: :memberships

end