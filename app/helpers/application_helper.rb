module ApplicationHelper

  def markdown(text)
    output = text.lines.map do |line|
      process_line line
    end.join
    RedcarpetCompat.new(output, :fenced_code, :gh_blockcode)
  end

  def process_line(line)
    match = match_gist line
    return "<div id=\"#{match[1]}\" class=\"gist-files\">Loading gist...</div>" if match

    match = match_youtube line
    return render(:partial => 'youtube', :locals => { :video => match[1] }) if match

    # match = match_image line
    # # return "<img title=\"#{match[1]}\" src=\"#{match[2]}\" class=\"#{match[4]}\">" if match
    # return "<img title=\"#{match[1]}\" src=\"#{match[2]}\" class=\"img-responsive\">" if match

    line
  end
  
  def match_gist(line)
    line.match(/\{\{gist\s+(.*)\}\}/)
  end

  def match_youtube(line)
    line.match(/^http.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/)
  end

  def match_image(line)
    puts "Trying to match"
    puts line
    # http://rubular.com/r/7JC7G3DvEJ
    # line.match(/^\!\[(.*)\]\((https?:\/\/[\S]+)(\s?\|(.*)\))*/)

    # http://rubular.com/r/fJgaMfNJEh
    line.match(/^\!\[(.*)\]\((https?:\/\/[\S]+)\)/)
  end



  # Bootstrap 3.0 - make flash messages correlate
  def bootstrap_class_for(flash_type)
    { success: "alert-success", error: "alert-error", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
  end


  def is_active?(link_path)
    current_page?(link_path) ? "active" : ""
   end
  
  
end
