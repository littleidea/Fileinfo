#!/usr/bin/env ruby20

class FileInfo
	def initialize(name)
		@name = name
		@type = nil
		@lines = 0
	end
	def print_name
		puts @name
	end
	def print_type
		print "Filetype: #{@type}\n"
	end
	def print_line_count
		print "Line count: #{@lines}\n\n"
	end
	def count_lines
		fd = File.open(@name, "r")
		fd.each_line do |line|
			if line.nil? != true
				@lines += 1
			end
		end
		fd.close
	end
	def get_type
		fd = File.open(@name, "r")
		fd.each_line do |line|
			if line =~ /^int main((...))(\w|{)/
				@type = "C source file (.c)"
			elsif line =~ /^#\/usr\/bin\/env\wruby/
				@type = "Ruby source file (.rb)"
			elsif line =~ /^<html>/
				@type = "HTML (.html)"
			elsif @type.nil?
				@type = "Normal text file(?)"
			end
		end
		fd.close
	end
end


if __FILE__ == $0
	puts "Analyzing #{ARGV.length} files"
	files ||= Array.new

	ARGV.each do |arg|
		files << FileInfo.new(arg)
	end

	files.each do |file|
		file.print_name
		file.get_type
		file.count_lines
		file.print_type
		file.print_line_count
	end
end

