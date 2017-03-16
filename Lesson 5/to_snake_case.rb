#!/usr/bin/env ruby
require 'tempfile'

def snaked(str)
  if str =~ /([a-z])([A-Z])/
    upd_str = str.sub(/[a-z][A-Z]/, "#{$1}_#{$2}")
  else
    upd_str = str
  end
  upd_str.downcase
end


dir = Dir.new("./")
FileUtils.mkdir("old~") if !File.exist? "old~"

dir.each do |filename|
  if filename =~ /.*\.rb/ && filename != "to_snake_case.rb"
    temp = Tempfile.new('change_file')
    
    file = File.new(filename)
    file.each do |line|
      if line =~ /^require_relative '(.*)'$/
        updated = snaked($1)
        temp.puts "require_relative '#{updated}'"
      else
        temp.puts line
      end 
    end
    temp.close
    
    newname = snaked(filename)
    puts newname
    
    FileUtils.mv(filename, "old~/#{filename}")
    FileUtils.mv(temp, newname)
  end
end

