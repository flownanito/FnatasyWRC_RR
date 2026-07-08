#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'
require 'fileutils'

puts "Downloading drivers from motorsport.com..."
url = "https://es.motorsport.com/wrc/drivers/"
dir = File.expand_path('../app/assets/images/drivers', __dir__)
FileUtils.mkdir_p(dir)

begin
  doc = Nokogiri::HTML(URI.open(url))
  items = doc.css('.ms-grid__item, .driver-card, a.ms-item--driver, .ms-driver-directory-item, a[href*="/driver/"]')
  
  items.each do |item|
    name = item.text.strip.gsub(/\s+/, ' ')
    # Filter out F1/MotoGP drivers that somehow appear on the bottom (Alonso, Marquez)
    next if name.include?('Alonso') || name.include?('Marquez') || name.include?('Márquez')
    
    img = item.at_css('img')
    img_src = img ? (img['src'] || img['data-src']) : nil
    href = item['href'] || (item.at_css('a') ? item.at_css('a')['href'] : nil)
    
    if href && href.include?('/driver/') && name.length > 3 && img_src
      # Parse the name. Example: "1 Sébastien Ogier Equipo: Toyota Racing..."
      clean_name = name.match(/([A-Za-zÀ-ÿ\s]+)(Equipo:|Fecha|$)/)
      clean_name = clean_name ? clean_name[1].strip.gsub(/^\d+\s/, '') : name
      
      slug = clean_name.downcase.gsub(/[^a-z0-9]+/, '-')
      
      # Handle generic avatars so we don't save broken images
      next if img_src.include?('driver_logo.jpg')
      
      puts "Downloading: #{clean_name} -> #{slug}.webp"
      
      file_path = File.join(dir, "#{slug}.webp")
      File.open(file_path, 'wb') do |f|
        f.write(URI.open(img_src).read)
      end
    end
  end
  puts "Download complete!"
rescue => e
  puts "Error: #{e.message}"
end
