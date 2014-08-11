#!/usr/bin/env ruby

class FileInfo
	def initialize(name)
		@name = name
		@type = nil
		@lines = 0
	end
	
	def print_info
		print "Name: #{@name}\n"
		print "Filetype: #{@type}\n"
		print "Line count: #{@lines}\n\n"
	end

	def count_lines
		if @lines != 0
			return
		end

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
				@type = "C source file (*.c)"

			elsif line =~ /#!\/bin\/bash/ or line =~ /#!\/bin\/sh/
				@type = "Shell script (*.sh)"

			elsif line =~ /#!\/usr\/bin\/env ruby/
				@type = "Ruby source file (*.rb)"

			elsif line =~ /^<html>/
				@type = "HTML (*.html)"

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
		file.get_type
		file.count_lines
		file.print_info
	end
end
