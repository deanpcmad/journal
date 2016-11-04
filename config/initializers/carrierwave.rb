CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              "AWS",
    aws_access_key_id:     ENV["AWS_ACCESS_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ID"],
    region:                "eu-west-1"
  }
  config.fog_directory  = ENV["FOG_DIRECTORY"]
  config.fog_public     = false
end
