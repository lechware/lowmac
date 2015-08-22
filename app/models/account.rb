class Account < ActiveRecord::Base

  # Validations
  validates :name, :address, :business_number, :phone, :email, presence: true
  validates :name, :address, :business_number, uniqueness: true

  mount_uploader :logo, ImageUploader

  def to_s
    self.name
  end  

  def address_line_1
    self.address.split(',').first
  end

  def address_line_2
    a = self.address
    a.slice!(address_line_1)
    return a.reverse.chomp(',').reverse
  end

end
