#!/usr/bin/env ruby

# frozen_string_literal: true

# This is originally from: https://github.com/alexharv074/markdown_toc

TOP = 2
MAX = 4

def usage
  puts <<~USAGE
    Usage: #{$PROGRAM_NAME} FILE.md [TOP [MAX]] [-h]
      FILE.md    Markdown source document
      TOP        top-level Markdown heading level (default #{TOP})
      MAX        maximum heading level (default #{MAX})
  USAGE
  exit 1
end

# A class that's designed read a Markdown file, and automatically generate
# a Markdown Table of Contents based on the file's header's specified by #s.
class ToCWriter
  def initialize(source_file, top = TOP, max = MAX)
    @source_file = source_file
    @top = top.to_i
    @max = max.to_i
    @seen = []
    @level = ''
    @start = ''
    @header = ''
    @anchor = ''
  end

  def write
    File.open(@source_file).each_line.with_index(1) do |line, line_number|
      next if line_number == 1
      next unless line.match?(/^#/)

      @level, @header = line.match(/^(#+) *(.*) *$/).captures
      next if ignore_this_header?

      set_anchor
      set_start

      puts "#{@start} [#{@header}](##{@anchor})"
    end
  end

  private

  def ignore_this_header?
    @header == 'Table of Contents' || \
      @level.length < @top || \
      @level.length > @max
  end

  def set_anchor
    @anchor = @header.downcase.gsub(/[^a-z\d_\- ]+/, '').tr(' ', '-')
    update_if_seen
  end

  def update_if_seen
    inc = 2
    while @seen.include?(@anchor)
      if inc == 2
        @anchor += '-' + inc.to_s
      else
        @anchor.sub!(/-\d+$/, '-' + inc.to_s)
      end
      inc += 1
    end
    @seen << @anchor
  end

  def set_start
    len = @level.length
    bullet = len.even? ? '-' : '*'
    @start = '  ' * (len - @top) + bullet
  end
end

usage if ARGV.length.zero?
usage if ARGV[0] == '-h'

ToCWriter.new(*ARGV).write if $PROGRAM_NAME == __FILE__
