class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?

  def as_json(opts = {})
    super(opts.merge(only: [ :id, :email, :name ]))
  end
end
