#include <stdio.h>
#include <math.h>

int main (int argc, char *argv[])
{
  char units_map [7][10] = { "Nano", "Micro", "Milli", "Unit", "Thousand", "Million", "Billion" };
  int exponents_map[7] = { -9, -6, -3, 0, 3, 6, 9 };
  float number = 1234;
  int exponent = floor(log10(number));
  if (fmod(exponent, 3) != 0 && exponent >= -11 && exponent <= 11) exponent = (exponent / 3) * 3;
  
  int i = 0;
  while(i<7)
  {
    if(exponents_map[i] == exponent) break;
    i++;
  }

  char *unit = units_map[i];
  float value =  number / pow(10.0, exponent);
  printf("%f %s\n", value, unit);

  return 0;
}
