# This is a Jekyll plugin that makes it possible to
# access lists of file names inside Jekyll.
#
# # Usage
#
# Place this file inside the `_plugins` directory and
# Jekyll should recognize it.
#
# Then, anywhere on your files use the following tag:
#
# {% loop_directory directory:images iterator:file filter:*.jpg sort:descending %}
#     <img src="{{ image }}" />
# {% endloop_directory %}
#
# Author: Jairo Gatjens <https://github.com/jgatjens>
# Source: https://gist.github.com/jgatjens/8925165
# Why?    http://stackoverflow.com/a/21688974

module Jekyll
  class LoopDirectoryTag < Liquid::Block

    include Liquid::StandardFilters
    Syntax = /(#{Liquid::QuotedFragment}+)?/

    def initialize(tag_name, markup, tokens)
      @attributes = {}

      @attributes['directory'] = '.';
      @attributes['iterator']  = 'file';
      @attributes['filter']    = 'item';
      @attributes['sort']      = 'ascending';

      # Parse parameters
      if markup =~ Syntax
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      else
        raise SyntaxError.new("Bad options given to 'loop_directory' plugin.")
      end

      #if @attributes['directory'].nil?
      # raise SyntaxError.new("You did not specify a directory for loop_directory.")
      #end

      super
    end

    def render(context)
      context.registers[:loop_directory] ||= Hash.new(0)

      files = Dir.glob(File.join(@attributes['directory'], @attributes['filter']))

      if @attributes['sort'].casecmp( "descending" ) == 0
        # Find files and sort them reverse-lexically. This means
        # that files whose names begin with YYYYMMDD are sorted newest first.
        files.sort! {|x,y| y <=> x }
      else
        # sort normally in ascending order
        files.sort!
      end

      result = []

      context.stack do


        # remove filename extension
        files.each { |pathname|
          context[@attributes['iterator']] = File.basename(pathname, @attributes['filter'].sub('*', ''))
          result << render_all(@nodelist, context)
        }

        # return pathname
        # files.each_with_index do |item, index|
        # context[@attributes['iterator']] = item
        # result << render_all(@nodelist, context)
        # end
      end

      result
    end
  end
end

Liquid::Template.register_tag('loop_directory', Jekyll::LoopDirectoryTag)

