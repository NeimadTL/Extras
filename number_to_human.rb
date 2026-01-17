PRECISION = 3
UNITS_TABLE = {
 3 => "Thousand",
 6 => "Million",
 9 => ""
}

def number_to_human(number, opts = {})  
  case (digits(number))
  when 4..6
    return "#{number/1000.0} Thousand"
  when 7..9
    return "#{number/1000000.0} Million"
  when 10..12
    return "#{number/1000000000.0} Billion"
  else
    number.to_s
  end
end


def digits(number)
  Math.log10(number).to_i + 1
end


puts "=> #{number_to_human(1).inspect}"
puts "=> #{number_to_human(10).inspect}"
puts "=> #{number_to_human(100).inspect}"
puts "=> #{number_to_human(1000).inspect}" # Thousand
puts "=> #{number_to_human(1000000).inspect}" # Million
puts "=> #{number_to_human(1000000000).inspect}" # Billion

