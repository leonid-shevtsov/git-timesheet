#!/usr/bin/env ruby

require 'optparse'
require 'time'

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: git-timesheet [options]"

  opts.on("-s", "--since [TIME]", "Start date for the report (default is 1 week ago)") do |time|
    options[:since] = time
  end
  
  opts.on("-a", "--author [EMAIL]", "User for the report (default is the author set in git config)") do |author|
    options[:author] = author
  end

  opts.on(nil, '--authors', 'List all available authors') do |authors|
    options[:authors] = authors
  end
end.parse!

options[:since] ||= '1 week ago'

if options[:authors]
  authors = `git log --no-merges --simplify-merges --format="%an (%ae)" --since="#{options[:since].gsub('"','\\"')}"`.strip.split("\n").uniq
  puts authors.join("\n")
else
  options[:author] ||= `git config --get user.email`.strip
  log_lines = `git log --no-merges --simplify-merges --author="#{options[:author].gsub('"','\\"')}" --format="%ad %s <%h>" --date=iso --since="#{options[:since].gsub('"','\\"')}"`.split("\n")
  day_entries = log_lines.inject({}) {|days, line|
    timestamp = Time.parse line.slice!(0,25)
    day = timestamp.strftime("%Y-%m-%d")
    days[day] ||= []
    days[day] << timestamp.strftime("%H:%S ") + line.strip
    days
  }.sort{|a,b| a[0]<=>b[0]}
  puts day_entries.map{|day, entries| "#{day}\n#{'='*10}\n\n#{entries.sort.join("\n")}\n\n"}
end
