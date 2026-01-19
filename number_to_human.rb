PRECISION = 3
UNITS_TABLE = {
 3 => "Thousand",
 6 => "Million",
 9 => "Billion"
}

def number_to_human(number, opts = {})
  exponent = exponent(number)

  "#{number/10.0**exponent} #{UNITS_TABLE[exponent]}".strip  
end

def exponent(number)
  exponent = Math.log10(number).floor

  unless exponent.modulo(3).zero?
    exponent = 3 if (3..5).include?(exponent)
    exponent = 6 if (6..8).include?(exponent)
    exponent = 9 if (9..12).include?(exponent)
  end

  exponent
end


puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(12).inspect}"
puts "=> #{number_to_human(123).inspect}"
puts "=> #{number_to_human(1234).inspect}"
puts "=> #{number_to_human(12345).inspect}"
puts "=> #{number_to_human(123456).inspect}"
puts "=> #{number_to_human(1234567).inspect}"
puts "=> #{number_to_human(12345678).inspect}"
puts "=> #{number_to_human(123456789).inspect}"
puts "=> #{number_to_human(1234567891).inspect}"
puts "=> #{number_to_human(12345678912).inspect}"
puts "=> #{number_to_human(123456789123).inspect}"

