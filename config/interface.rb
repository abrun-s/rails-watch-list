require_relative 'scraper'
require 'yaml'

begin
  movie_urls = movie_list
  movies = movie_urls.map do |url|
    scrape_movie(url)
  end
  p movies
  yaml_movies = YAML.dump(movies)

  File.open("movies.yml", "wb") do |file|
    file.write(yaml_movies)
  end
  # puts "movies.yml file created"
# rescue StandardError => e
  # puts "Error: #{e.message}"
end
