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

def calculate_value(number, exponent, precision)
  (number/10.0**exponent).truncate(precision)
end

def determine_unit(exponent)
  UNITS_TABLE[exponent]
end

def human_friendly_number(number, exponent, opts)
  precision = opts[:precision] ? opts[:precision] : PRECISION
  strip_zeros = opts[:strip_insignificant_zeros]
  separator = opts[:separator]
  units = opts[:units]

  value = strip_unsignificant_zeros(calculate_value(number, exponent, precision))
  value = calculate_value(number, exponent, precision) if strip_zeros == false
  value = value.to_s.gsub('.', separator) unless separator.nil?
  UNITS_TABLE.update(units) unless units.nil?
  unit = determine_unit(exponent)

  "#{value} #{unit}".strip
end

def strip_unsignificant_zeros(value)
  float, integer = value, value.to_i

  float == integer ? integer : float
end

puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(12).inspect}"
puts "=> #{number_to_human(123).inspect}"
puts "=> #{number_to_human(1234, units: {3=>'K', 9=>'B'}).inspect}"
puts "=> #{number_to_human(12_345).inspect}"
puts "=> #{number_to_human(123_456).inspect}"
puts "=> #{number_to_human(1_234_567).inspect}"
puts "=> #{number_to_human(12_345_678).inspect}"
puts "=> #{number_to_human(123_456_789).inspect}"
puts "=> #{number_to_human(1_234_567_890).inspect}"
puts "=> #{number_to_human(12_345_678_901).inspect}"
puts "=> #{number_to_human(123_456_789_012).inspect}"
puts "-> #{number_to_human(9.00001).inspect}"
puts "-> #{number_to_human(9.00001, strip_insignificant_zeros: false, precision: 5, separator: ',').inspect}"
