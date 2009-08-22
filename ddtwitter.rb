# DDTwitter
# Copyright (C) 2009 kana <http://whileimautomaton.net/>
# License: MIT license
#     Permission is hereby granted, free of charge, to any person obtaining
#     a copy of this software and associated documentation files (the
#     "Software"), to deal in the Software without restriction, including
#     without limitation the rights to use, copy, modify, merge, publish,
#     distribute, sublicense, and/or sell copies of the Software, and to
#     permit persons to whom the Software is furnished to do so, subject to
#     the following conditions:
# 
#     The above copyright notice and this permission notice shall be included
#     in all copies or substantial portions of the Software.
# 
#     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
#     OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#     MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#     IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
#     CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
#     TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
#     SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'optparse'
require 'pp'
require 'rubygems'
require 'twitter'




module DDTwitter
  VERSION = '0.0.0'

  class Driver
    def main(args)
      OptionParser.new do |o|
        o.banner = <<'END'
Usage: ruby ddtwitter.rb {command} {argument} ...
END

        o.on('-h', '--help', 'Show terse help.') do
          puts o.help
        end

        o.on('-v', '--version', 'Show version information.') do
          puts "DDTwitter #{DDTwitter::VERSION}"
        end
      end.parse!

      if ARGV.length == 0
        puts 'Command is required.'
        exit 1
      end

      command =  ARGV[0]
      if command == 'fetch'
      elsif command == 'block'
      elsif command == 'conversation-of'
      elsif command == 'favorite'
      elsif command == 'follow'
      elsif command == 'list'
      elsif command == 'post'
      elsif command == 'remove'
      elsif command == 'reply'
      elsif command == 'send-direct-message'
      elsif command == 'temporary-block'
      elsif command == '...'
        puts '...'
      else
        puts "Invalid command: #{command}"
        exit 1
      end
      0
    end
  end
end



if __FILE__ == $0
  exit DDTwitter::Driver.new.main ARGV
end

# __END__
