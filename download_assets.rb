#encoding: utf-8
require 'uri'

Dir.glob("*").each do |item|
  next if item == 'static'
  puts '- ' * 6 + item + ' -' * 6

  Dir.glob("#{item}/*.html") do |e|
    s = ''
    File.open(e, 'r') do |file|
      s = file.read

      s = s.gsub(/<img src="(.*?)" /) do |s|
        url = URI.encode("http:" + $1)
        image = $1.split('/').last

        if !Dir.glob("#{item}/images/*").include?("#{item}/images/" + image)
          puts '- ' * 10 + "downloding " + image + ' -' * 10
          `wget -P #{item}/images #{url}`
          puts '- ' * 10 + "downloding done" + ' -' * 10
        end

        '<img src="images/' + image + '" '
      end

      if s.include? '</video>'
        s = s.gsub(/<source src="(.*?)"/) do |s|
          url = URI.encode("http:" + $1)
          video = $1.split('/').last

          if !Dir.glob("#{item}/videos/*").include?("#{item}/videos/" + video)
            puts '- ' * 10 + "downloding " + video + ' -' * 10
            `wget -P #{item}/videos #{url}`
            puts '- ' * 10 + "downloding done" + ' -' * 10
          end

          '<img src="videos/' + video + '"'
        end
      end
    end
  end

  puts '- ' * 6 + item + ' done' + ' -' * 6
end
