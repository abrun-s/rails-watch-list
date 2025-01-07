require "nokogiri"
require "open-uri"

def crunchyroll_winter_lineup
  url = "https://www.imdb.com/list/ls590918784/?ref_=fea_wot_c_ls_crunchy_winter25_cta"
  html = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML.parse(html)
  anime_show_urls = []
  doc.search(".ipc-title-link-wrapper").each do |anime_card|
    anime_show_urls << "https://www.imdb.com#{ anime_card.attr("href").value.split("?")[0] }"
  end
  anime_show_urls
end

def movie_list
  url = "https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"
  html = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML.parse(html)
  movie_urls = []
  doc.search(".ipc-title-link-wrapper").first(20).each do |movie_card|
    movie_urls << "https://www.imdb.com#{ movie_card.attr("href").value.split("?")[0] }"
  end
  movie_urls
end

def show_list
  url = "https://www.imdb.com/chart/tvmeter/?ref_=nv_tvv_mptv"
  html = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML.parse(html)
  show_urls = []
  doc.search(".ipc-title-link-wrapper").first(20).each do |show_card|
    show_urls << "https://www.imdb.com#{ show_card.attr("href").value.split("?")[0] }"
  end
  show_urls
end

def scrape_show(url)
  html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML(html_content)

  return {
  title: doc.search('.hero__primary-text').text.strip,
  rating: doc.search('.sc-d541859f-2 kxphVf')[0].text.strip,
  storyline: doc.search("sc-3ac15c8d-1 gkeSEi").text.strip,
  cast: doc.search('.sc-cd7dc4b7-1').first(3).map { |el| el.text.strip },
  img: doc.search('.sc-7c0a9e7c-2 hXyMhR').attr('src').value.strip,
  genre: doc.search('.ipc-inline-list__item').text.strip,
   }
end

def scrape_movie(url)
  html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML(html_content)

  return {
  title: doc.search('.hero__primary-text').text.strip,
  rating: doc.search('.sc-d541859f-2 kxphVf')[0].text.strip,
  storyline: doc.search("sc-3ac15c8d-1 gkeSEi").text.strip,
  cast: doc.search('.sc-cd7dc4b7-1').first(3).map { |el| el.text.strip },
  img: doc.search('.sc-7c0a9e7c-2 hXyMhR').attr('src').value.strip,
  genre: doc.search('.ipc-inline-list__item').text.strip,
   }
end

def scrape_anime(url)
  html_content = URI.open(url, 'Accept-Language' => 'en', "User-Agent" => "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:89.0) Gecko/20100101 Firefox/89.0").read
  doc = Nokogiri::HTML(html_content)

  return {
  title: doc.search('.hero__primary-text').text.strip,
  rating: doc.search('.sc-d541859f-2 kxphVf')[0].text.strip,
  storyline: doc.search("sc-3ac15c8d-1 gkeSEi").text.strip,
  cast: doc.search('.sc-cd7dc4b7-1').first(3).map { |el| el.text.strip },
  img: doc.search('.sc-7c0a9e7c-0 ekJWmC').attr('src').value.strip,
  genre: doc.search('.ipc-inline-list__item').text.strip,
   }
end
