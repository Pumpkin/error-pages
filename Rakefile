desc 'Deploy error pages to S3'
task(:deploy) { AssetSynchronizer.sync }
task :default => :deploy


require 'aws'
require 'pathname'

class AssetSynchronizer
  def self.sync
    new.
      clear_existing_error_assets.
      upload_new_error_assets
  end

  def clear_existing_error_assets
    puts 'Clearing existing error assets...'
    bucket.objects.with_prefix('errors').each &:delete

    self
  end

  def upload_new_error_assets
    puts 'Uploading new error assets...'

    asset_paths.each do |asset_path|
      asset = upload_asset asset_path

      puts "Uploaded #{ asset_path } to #{ asset.public_url }"
    end

    self
  end

protected

  def bucket
    s3.buckets[s3_config['bucket']]
  end

  def s3
    @s3 ||= AWS::S3.new(s3_config)
  end

  def s3_config
    @s3_config ||= YAML.load(File.read(config_path))
  end

  def config_path
    File.expand_path 'aws_config.yml', File.dirname(__FILE__)
  end

  def asset_paths
    Dir.glob(Dir.glob(File.join(assets_path, '**', '*.*'))).map do |path|
      Pathname.new path
    end
  end

  def assets_path
    Pathname.new 'public'
  end

  def upload_asset(asset_path)
    bucket.
      objects[s3_asset_path_for(asset_path)].
      write(asset_path, :acl => :public_read)
  end

  def s3_asset_path_for(asset_path)
    File.join 'errors', Pathname.new(asset_path).relative_path_from(assets_path)
  end
end
