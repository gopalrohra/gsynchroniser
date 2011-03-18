require 'ftools'
require 'find'
class Synchroniser

def synchronise(source_dir, dest_dir)
s_dir=Dir.new(source_dir)
d_dir=Dir.new(dest_dir)

puts "Found #{s_dir.entries.length} items in source directory: #{source_dir}"
puts "Found #{d_dir.entries.length} items in Destination directory: #{dest_dir}"
puts "Synchronising #{source_dir} to #{dest_dir}"

files, directories=[],[]
s_dir.each do |member|
if  File.directory?(source_dir+"/"+member)
directories<<member  if(member!="." and member!="..")
else
files<< member 
end
end

files.each do |file|
if File.exist?("#{dest_dir}/#{file}")
if(File.mtime("#{source_dir}/#{file}")>File.mtime("#{dest_dir}/"))
File.copy source_dir+"/"+file, "#{dest_dir}/"
end
else
File.copy source_dir+"/"+file, "#{dest_dir}/"
end
end
directories.each do |dir|
if !d_dir.member?(dir)
Dir.mkdir("#{dest_dir}/#{dir}")
end
synchronise("#{source_dir}/#{dir}", "#{dest_dir}/#{dir}")
 end
 end
end
