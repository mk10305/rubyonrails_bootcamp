arr = ['snow', 'winter', 'ice', 'slippery', 'salted_ roads', 'white trees']


arr.delete_if do |word|
	word.start_with?("s")
end


arr.each do |word|
puts word
end

