module HelperMethods
  def wr_p(text)
    puts "["+Time.now.to_s+"] " + text.to_s
  end
  def wr_d(text)
		if ENV['WR_DEBUG']
			puts "["+Time.now.to_s+"] " + text.to_s
		end
  end
	def wr_tag(text, tag)
			puts "["+tag.to_s+"] " + text.to_s
  end
end