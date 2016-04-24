class Article < ActiveRecord::Base
  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 200 }
  validate :check_expired_at

  private
  def check_expired_at
    if expired_at && expired_at < released_at
      errors.add(:expired_at, :expired_at_too_old)
    end
  end
end
