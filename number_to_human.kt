import kotlin.math.*
    
fun convert(number: Double, units: Map<String, String> = emptyMap<String, String>()): String {
    val unitsMap = mapOf("Nano" to -9, "Micro" to -6, "Milli" to -3 , "Unit" to 0, "Thousand" to 3, "Million" to 6, "Billion" to 9)    
    var exponent = Math.floor(Math.log10(number)).toInt()
    if (exponent.mod(3) != 0 &&  exponent in -11..11) exponent = (exponent / 3) * 3

    var exponentsMap = unitsMap.entries.associate { (k, v) -> v to k }.toMutableMap()
    units.forEach { (unit_key, custom_v) ->
    	val lookup_key = exponentsMap.filterValues { it == unit_key }.keys;
        if (lookup_key.iterator().hasNext()) exponentsMap.put(lookup_key.iterator().next(), custom_v)
    }
      
    val unit = exponentsMap.get(exponent)
    val value = (number/10.0.pow(exponent))
    
    return "$value $unit"
}

fun main() {
    val number = 0.001
    var customUnits = mapOf("Nano" to "nA", "Micro" to "μA", "Milli" to "mA" , "Unit" to "A", "Thousand" to "kA", "Million" to "MA", "Billion" to "GA")
    
    println(convert(1.0, customUnits))
    println(convert(12.0, customUnits))
    println(convert(123.0, customUnits))
    println(convert(1234.0, customUnits))
    println(convert(12345.0, customUnits))
    println(convert(123456.0, customUnits))
    println(convert(1234567.0, customUnits))
    println(convert(12345678.0, customUnits))
    println(convert(123456789.0, customUnits))
    println(convert(0.1, customUnits))
    println(convert(0.01, customUnits))
    println(convert(0.001, customUnits))
    println(convert(0.0001, customUnits))
    println(convert(0.00001, customUnits))
    println(convert(0.000001, customUnits))
    println(convert(0.000001))
}
