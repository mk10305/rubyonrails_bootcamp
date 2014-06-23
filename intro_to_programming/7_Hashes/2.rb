cat = {name: "whiskers"}

weight = {weight: "10 lbs"}

puts cat.merge(weight)

# each respective hash remains the same

puts cat

puts weight

puts cat.merge!(weight)

#merge! permanently modifies the cat hash so that it prints out the combination

puts cat 

puts weight