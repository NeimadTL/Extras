PRECISION = 3
UNITS_TABLE = {
 3 => "Thousand",
 6  => "Million",
 9 => "Billion"
}

def number_to_human(number, opts = {})
  exponent = exponent(number)
  return "#{number/10.0**exponent} #{UNITS_TABLE[exponent]}".strip  
end


def exponent(number)
  Math.log10(number).floor
end


puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(10).inspect}"
puts "=> #{number_to_human(100).inspect}"
puts "=> #{number_to_human(1000).inspect}" # Thousand
puts "=> #{number_to_human(1234).inspect}" # Thousand
puts "=> #{number_to_human(12345).inspect}" # Thousand
puts "=> #{number_to_human(1000000).inspect}" # Million
puts "=> #{number_to_human(1000000000).inspect}" # Billion

