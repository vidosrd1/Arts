# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
path = "https://raw.githubusercontent.com/ruby-conferences/ruby-conferences.github.io/master/_data/conferences.yml"
url = URL.open(path)
yaml = YAML.load_file url, permitted_classes: [Date]

yaml.each do |event|
  Event.create!
  {
    name: event["name"],
    location: event["location"],
    start_data: event["start_data"]
  }
end
