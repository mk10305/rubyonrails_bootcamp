a = ['white snow', 'winter wonderland', 'melting ice', 'slippery sidewalk', 'salted roads', 'white trees']


a = a.map do |pairs|
	pairs.split
end


a = a.flatten

p a
