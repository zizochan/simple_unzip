#!/usr/bin/ruby

# require
require "zip"
require "readline"

# dir
zips_dir   = ARGV[0] || "#{Dir.home}/tmp"
output_dir = File.join(zips_dir, "output")

# confirm
puts "zips_dir is '#{zips_dir}'. OK? (y/n)"
input = Readline.readline
raise("abort") unless input == "y"

# get files
zip_files = Dir.glob(File.join(zips_dir, "*.zip"))
raise "[error] no zip file in '#{zips_dir}'." if zip_files.empty?

# mkdir
unless Dir.exist?(output_dir)
  Dir.mkdir(output_dir)
end

# unzip
zip_files.each do |zip_file|
  origin_filename = File.basename(zip_file, ".zip")
  Zip::File.open(zip_file) do |zip|
    zip.each do |entry|
      new_filename = "#{origin_filename}_#{entry}"
      puts new_filename

      zip.extract(entry, File.join(output_dir, new_filename))
    end; nil
  end
end

# close
puts "finish"
