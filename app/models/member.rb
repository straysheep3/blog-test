class Member < ActiveRecord::Base
  include EmailAddressChecker
  
  validates :number, presence: true,
    numericality: { only_integer: true,
      greater_than: 0, less_than: 100, allow_blank: ture },
    uniqueness: true

  validates :name, presence: ture,
    format: { with: /\A[A-Za-z]\w*\z/, allow_blank: true },
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }

  validates :full_name, length: { maximum: 20}

  validate :check_email

  private
  def method_name
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end

  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
          "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
