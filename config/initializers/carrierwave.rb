CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = ENV["S3_BUCKET_NAME"]
  # config.aws_acl    = :public_read
  config.asset_host = "#{ENV["AWS_ASSET_HOST"]}/#{ENV["S3_BUCKET_NAME"]}"
  config.aws_authenticated_url_expiration = 60 * 60 # * 24 * 365

  config.aws_credentials = {
    access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
    secret_access_key: ENV["AWS_ACCESS_KEY"],
    region:            ENV['AWS_REGION']
  }
  config.root = Rails.root.join('tmp')
end