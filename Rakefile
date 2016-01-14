require "aws-sdk"
require "dotenv"

Dotenv.load

desc "Build"
task :build do
  system("JEKYLL_ENV=#{ENV['JEKYLL_ENV']} jekyll build --config ./_config_#{ENV['JEKYLL_ENV']}.yml")
end

desc "Serve"
task :serve do
  system("JEKYLL_ENV=#{ENV['JEKYLL_ENV']} jekyll serve --config ./_config_#{ENV['JEKYLL_ENV']}.yml")
end

def traverse_directory(path)
  Dir.entries(path).map do |f|
    next if [".", ".."].include? f
    f_path = File.join(path, f)
    if File.directory? f_path
      traverse_directory f_path
    else
      f_path
    end
  end
end

desc "Deploy via S3"
task :s3 do

  local_dir = './_site'

  access_key = ENV['AWS_ACCESS_KEY']
  secret_key = ENV['AWS_SECRET_KEY']
  region = ENV['AWS_REGION']
  bucket_name = ENV['AWS_BUCKET_NAME']

  s3 = Aws::S3::Client.new(
    region: region,
    credentials: Aws::Credentials.new(access_key, secret_key)
  )

  page = s3.list_objects(bucket: bucket_name)

  p "deleting content"
  loop do
    page.contents.each do |ob|
      s3.delete_object bucket: bucket_name, key: ob.key
    end
    break unless page.next_page?
    page = page.next_page
  end

  p "uploading _site"
  traverse_directory(local_dir).flatten.compact.each do |f|
    key = f.gsub(local_dir+"/", "")
    s3.put_object bucket: bucket_name, key: key, body: File.open(f), acl: "public-read"
  end

  p "s3 deploy complete"
end
