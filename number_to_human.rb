PRECISION = 3
UNITS_TABLE = {
 3 => "Thousand",
 6 => "Million",
 9 => "Billion"
}

def number_to_human(number, opts = {})
  exponent = exponent(number)

  human_friendly_number(number, exponent, opts)
end

def exponent(number)
  exponent = Math.log10(number).floor

  unless exponent.modulo(3).zero?
    exponent = 0 if exponent < 3
    exponent = 3 if (3..5).include?(exponent)
    exponent = 6 if (6..8).include?(exponent)
    exponent = 9 if (9..12).include?(exponent)
  end

  exponent
end

def calculate_value(number, exponent)
  (number/10.0**exponent).truncate(PRECISION)
end

def determine_unit(exponent)
  UNITS_TABLE[exponent]
end

def human_friendly_number(number, exponent, opts)
   value = strip_unsignificant_zeros(calculate_value(number, exponent))
   
   with_zeros = opts[:strip_insignificant_zeros]
   value = calculate_value(number, exponent) if with_zeros == false
   unit = determine_unit(exponent)

  "#{value} #{unit}".strip
end

def strip_unsignificant_zeros(value)
  float, integer = value, value.to_i

  float == integer ? integer : float
end

puts "-> #{number_to_human(12.00001).inspect}"
puts "-> #{number_to_human(12.00001, strip_insignificant_zeros: false).inspect}"

puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(12).inspect}"
puts "=> #{number_to_human(123).inspect}"
puts "=> #{number_to_human(1234).inspect}"
puts "=> #{number_to_human(12345).inspect}"
puts "=> #{number_to_human(123456).inspect}"
puts "=> #{number_to_human(1234567).inspect}"
puts "=> #{number_to_human(12345678).inspect}"
puts "=> #{number_to_human(123456789).inspect}"
puts "=> #{number_to_human(1234567890).inspect}"
puts "=> #{number_to_human(12345678901).inspect}"
puts "=> #{number_to_human(123456789012).inspect}"

