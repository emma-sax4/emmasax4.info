#!/usr/bin/env ruby

# This is originally from: https://github.com/alexharv074/markdown_toc

TOP = 2; MAX = 4

def usage
  puts <<-EOF
Usage: #{$0} FILE.md [TOP [MAX]] [-h]
     FILE.md    Markdown source document
     TOP        top-level Markdown heading level (default #{TOP})
     MAX        maximum heading level (default #{MAX})
EOF
  exit 1
end

class ToCWriter
  def initialize(source_file, top=TOP, max=MAX)
    @source_file = source_file
    @top = top.to_i
    @max = max.to_i
    @seen = []
    @level = ""
    @start = ""
    @header = ""
    @anchor = ""
  end

  def write
    open_file.each_line.with_index(1) do |line, line_number|
      next if line_number == 1
      next unless line.match(/^#/)
      @level, @header = line.match(/^(#+) *(.*) *$/).captures
      next if ignore_this_header?

      set_line(line)
    end
  end

  private

  def open_file
    File.open(@source_file)
  end

  def set_line(line)
    set_anchor
    set_start
    puts "#{@start} [#{@header}](##{@anchor})"
  end

  def ignore_this_header?
    @header == "Table of contents" || \
      @level.length < @top || \
      @level.length > @max
  end

  def set_anchor
    @anchor = @header.downcase.gsub(/[^a-z\d_\- ]+/, "").gsub(/ /, "-")
    update_if_seen
  end

  def update_if_seen
    inc = 2
    while @seen.include?(@anchor)
      if inc == 2
        @anchor += "-" + inc.to_s
      else
        @anchor.sub!(/-\d+$/, "-" + inc.to_s)
      end
      inc += 1
    end
    @seen << @anchor
  end

  def set_start
    len = @level.length
    bullet = len % 2 == 0 ? "-" : "*"
    @start = "  " * (len - @top) + bullet
  end
end

usage if ARGV.length == 0
usage if ARGV[0] == "-h"

if $0 == __FILE__
  ToCWriter.new(*ARGV).write
end
