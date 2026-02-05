import kotlin.math.*

fun main() {
    val number = 0.001
    var customUnit = mapOf("Nano" to "nA", "Micro" to "μA", "Milli" to "mA" , "Unit" to "A", "Thousand" to "kA", "Million" to "MA", "Billion" to "GA")
    val unitsMap = mapOf("Nano" to -9, "Micro" to -6, "Milli" to -3 , "Unit" to 0, "Thousand" to 3, "Million" to 6, "Billion" to 9)
    var exponent = Math.floor(Math.log10(number)).toInt()
    if (!exponent.mod(3).equals(0)){
        if ((-9..-7).contains(exponent)) exponent = -9
        if ((-6..-4).contains(exponent)) exponent = -6
        if ((-3..-1).contains(exponent)) exponent = -3
        if ((0..2).contains(exponent)) exponent = 0
        if ((3..5).contains(exponent)) exponent = 3
        if ((6..0).contains(exponent)) exponent = 6
        if ((9..12).contains(exponent)) exponent = 9
    }
    var exponentsMap = unitsMap.entries.associate { (k, v) -> v to k }.toMutableMap()
    customUnit.forEach { (unit_key, custom_v) ->
        val lookup_key = exponentsMap.filterValues { it == unit_key }.keys;
	if (lookup_key.iterator().hasNext()) exponentsMap.put(lookup_key.iterator().next(), custom_v)
    }

    val unit = exponentsMap.get(exponent)
    val value = (number/10.0.pow(exponent))
    println("$value $unit")
}
