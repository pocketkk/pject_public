if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',       # required
      :aws_access_key_id      => 'AKIAJQVSMTORGRSHS2BA  ',       # required
      :aws_secret_access_key  => '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',       # required
      :region                 => 'us-east-1',  # optional, defaults to 'us-east-1'
      :persistent             => false #required to keep from timing out on PUT requests
    }
    config.fog_directory  = 'workordermachine'               # required
    config.fog_public     = true                    # optional, defaults to true
    config.fog_attributes = {}                      # optional, defaults to {}
                                                    # optional, defaults to nil
  end
end

