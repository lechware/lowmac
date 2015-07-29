class Account < ActiveRecord::Base

  # include Mongoid::Document
  # include Mongoid::Timestamps

  #
  # Associations
  #
  # has_many :users, autosave: false
  
  # #
  # # Fields
  # #
  # field :name, type: String
  # field :address, type: String
  # field :company_number, type: String
  # field :phone, type: String
  # field :email, type: String

  #
  # Validations
  #
  validates :name, :address, :business_number, :phone, :email, presence: true
  validates :name, :address, :business_number, uniqueness: true

  # validates_presence_of :name, :address, :company_number, :phone, :email
  # validates_uniqueness_of :name,  :address, :company_number

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
