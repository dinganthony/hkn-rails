module ApplicationHelper
  # http://unixmonkey.net/?p=20
  # HTML encodes ASCII chars a-z, useful for obfuscating
  # an email address from spiders and spammers
  def html_obfuscate(string)
    output_array = []
    lower = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    upper = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
    char_array = string.split('')
    char_array.each do |char|  
      output = lower.index(char) + 97 if lower.include?(char)
      output = upper.index(char) + 65 if upper.include?(char)
      if output
        output_array << "&##{output};"
      else 
        output_array << char
      end
    end
    return output_array.join
  end

  def sort_link(inner_text, sort_variable, opts = {})
    sort_direction = 'up'
    puts @search_opts.to_json
    if sort_variable == @search_opts['sort'] and @search_opts['sort_direction'] != 'down'
      sort_direction = 'down'
    end
    arrow = (sort_variable == @search_opts['sort']) ? (@search_opts['sort_direction'] == 'down') ? image_tag('site/arrow_desc.gif') : image_tag('site/arrow_asc.gif') : ''
    link_to(inner_text, @search_opts.merge('sort' => sort_variable, 'sort_direction' => sort_direction).merge(opts)) + arrow
  end
end
