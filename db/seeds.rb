#path = "https://raw.githubusercontent.com/ruby-conferences/ruby-conferences.github.io/master/_data/conferences.yml"
#url = URL.open(path)
#yaml = YAML.load_file url, permitted_classes: [Date]

#yaml.each do |event|
#  Event.create!
#  {
#    name: event["name"],
#    location: event["location"],
#    start_data: event["start_data"]
#  }
#end
10.times.with_index do |i|
  Post.create(
  #Post.destroy_all(
    title: Faker::Lorem.sentence(word_count: 3),
    name: "Angel",#Faker::Name.name,
    body: Faker::Lorem.paragraph(sentence_count: 18),
  )
end
