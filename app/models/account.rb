class Account

  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Associations
  #

  has_many :users, autosave: false
  # has_many :invoices

  #
  # Fields
  #

end
