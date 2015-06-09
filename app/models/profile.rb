class Profile 

  include Mongoid::Document
  include Mongoid::Timestamps

  #
  # Relations
  #
  embedded_in :user

  #
  # Uploaders
  #
  mount_uploader :avatar, AvatarUploader

  field :phone, type: String, default: ""

end
