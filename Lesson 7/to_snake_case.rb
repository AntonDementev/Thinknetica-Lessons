#!/usr/bin/env ruby
require 'tempfile'

def snaked(str)
  upd_str = if str =~ /([a-z])([A-Z])/
              str.sub(/[a-z][A-Z]/, "#{Regexp.last_match(1)}_#{Regexp.last_match(2)}")
            else
              str
            end
  upd_str.downcase
end

dir = Dir.new('./')
FileUtils.mkdir('old~') unless File.exist? 'old~'

dir.each do |filename|
  next unless filename =~ /.*\.rb/ && filename != 'to_snake_case.rb'
  temp = Tempfile.new('change_file')

  file = File.new(filename)
  file.each do |line|
    if line =~ /^require_relative '(.*)'$/
      updated = snaked(Regexp.last_match(1))
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
