require 'rubygems'
require 'zip'

folder = "/home/deployer/test_proj/file_navigator"
input_filenames = ['Gemfile', 'Gemfile.lock']
directory = '/home/deployer/test_proj/file_navigator'

zipfile_name = "/home/deployer/test_proj/file_navigator/archive_#{Time.now}.zip"

Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
  input_filenames.each do |filename|

    # Two arguments:
    # - The name of the file as it will appear in the archive
    # - The original file, including the path to find it
    zipfile.add(filename, folder + '/' + filename)
  end

  Dir[File.join(directory, '**', '**')].each do |file|
    zipfile.add(file.sub(directory, 'n'), file)
  end
end