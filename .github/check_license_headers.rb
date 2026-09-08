LICENSE = File.read('./.github/license-header.txt')
files = `git ls-files | grep -E '\.rb|Rakefile|\.rake|\.erb|Gemfile|gemspec'`.split("\n")
errors = []

files.each do |file|
  unless File.read(file).include?(LICENSE)
    errors << file
    puts "#{file} doesn't contain the correct license header"
  end
end

if errors.empty?
  puts 'All checked files have the correct license header'
else
  exit 1
end
