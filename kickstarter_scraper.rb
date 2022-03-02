require 'Nokogiri'
require 'pry'


def create_project_hash
  html = File.read('fixtures/kickstarter.html')

  kickstarter = Nokogiri.HTML(html)
  project = kickstarter.css(".project.grid_4")

  projects = {}

  project.each do |p| 
    title = p.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: p.css(".projectphoto-little").attribute("src").value,
      description: p.css("p.bbcard_blurb").text,
      location: p.css("span.location-name").text,
      percent_funded: p.css('ul.project-stats li.first.funded strong').text.gsub("%", "").to_i,
    }
  end
  
  projects

end