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

module Enumerable
  alias :filter :find_all
  alias :contains? :member?
end




module DDTwitter
  VERSION = '0.0.0'

  class Command
    def self.command_from_command_name(command_name)
      return eval('Command' +
                  command_name.
                  split(/-/).
                  map {|_| _[0].chr.upcase + _[1..._.length]}.
                  join('')).
             new
    end

    def self.command_name_from_class_name(class_name)
      return class_name.
        split(/::/)[-1].
        sub(/^Command/, '').
        split(/(?=[A-Z])/).
        map {|_| _.downcase}.
        join('-')
    end

    def do(*args)
      raise NotImplementedError
    end

    def help(*args)
      raise NotImplementedError
    end
  end

  class CommandBlock < Command
  end

  class CommandPost < Command
  end

  # More commands.

  class Driver
    def available_commands()
      return DDTwitter.constants.
        filter {|_| _ =~ /^Command([A-Z][a-z]*)+$/}.
        map {|_| Command.command_name_from_class_name _}
    end

    def do_command(command_name, args)
      command = Command.command_from_command_name(command_name)
      command.do(*args)
    end

    def main(args)
      OptionParser.new do |o|
        o.banner = <<'END'
Usage: ruby ddtwitter.rb {command} {argument} ...
END

        o.on('-h', '--help', 'Show terse help.') do
          puts o.help
          return 0
        end

        o.on('-v', '--version', 'Show version information.') do
          puts "DDTwitter #{DDTwitter::VERSION}"
          return 0
        end
      end.parse!

      if ARGV.length == 0
        puts 'Command is required.'
        return 1
      end

      given_command =  ARGV[0]
      if not valid_command? given_command
        puts "Invalid command: #{given_command}"
        return 1
      end

      do_command given_command, ARGV[1..ARGV.length]

      return 0
    end

    def valid_command?(command_name)
      return available_commands.contains? command_name
    end
  end
end



if __FILE__ == $0
  exit DDTwitter::Driver.new.main ARGV
end

# __END__
