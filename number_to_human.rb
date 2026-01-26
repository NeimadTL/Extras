#integers: :unit, :ten, :hundred, :thousand, :million, :billion, :trillion, :quadrillion
#fractionals: :deci, :centi, :mili, :micro, :nano, :pico, :femto



PRECISION = 3
UNITS_TABLE = {
 :thousand => 3,
 :million => 6,
 :billion => 9
}
EXPONENTS_TABLE = UNITS_TABLE.invert

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
  EXPONENTS_TABLE[exponent]
end

def human_friendly_number(number, exponent, opts)
  precision = opts[:precision] ? opts[:precision] : PRECISION
  strip_zeros = opts[:strip_insignificant_zeros]
  separator = opts[:separator]
  units = opts[:units]

  value = strip_unsignificant_zeros(calculate_value(number, exponent, precision))
  value = calculate_value(number, exponent, precision) if strip_zeros == false
  value = value.to_s.gsub('.', separator) unless separator.nil?
  update_units(units) unless units.nil?
  unit = determine_unit(exponent)

  "#{value} #{unit}".strip
end

def strip_unsignificant_zeros(value)
  float, integer = value, value.to_i

  float == integer ? integer : float
end

def update_units(custom_units)
  custom_units.each do |unit_key, custom_v|
    lookup_key = EXPONENTS_TABLE.key(unit_key)
    EXPONENTS_TABLE[lookup_key] = custom_v
  end
end

puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(12).inspect}"
puts "=> #{number_to_human(123).inspect}"
puts "=> #{number_to_human(1234, units: {:thousand=>'K', :billion=>'B'}).inspect}"
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
