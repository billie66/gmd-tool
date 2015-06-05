#encoding: utf-8

Dir.glob("*").each do |item|
  next if item == 'static'
  puts '- ' * 6 + item + ' -' * 6

  Dir.glob("#{item}/*.html") do |e|
    s = ''
    File.open(e, 'r') do |file|
      s = file.read

      s = s.gsub(/<img src="(.*?)"/) do |s|
        '<img src="images/' + $1.split('/').last + '"'
      end

      if s.include? '</video>'
        s = s.gsub(/<source src="(.*?)"/) do |s|
          '<img src="videos/' + $1.split('/').last + '"'
        end
      end
    end

    File.open(e, 'w') do |file|
      file.write(s)
    end
  end

  puts '- ' * 6 + item + ' done' + ' -' * 6
end
