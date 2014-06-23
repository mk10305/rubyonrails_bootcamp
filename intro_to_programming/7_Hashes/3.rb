cat = {name: "whiskers", weight: "10 lbs", color: "black"}


cat.each_key {|key| puts key}

cat.each_value{|value| puts value}


cat.each do |key, value|

	puts "The key is #{key} and the value is #{value}"

end

