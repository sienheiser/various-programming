#include <ctype.h>
#include <math.h>
/* atof: convert string s to double */
double atof(char s[])
{
    int i,sign,powersign;
    double val, power, exponent;

    for (i = 0; isspace(s[i]);i++)
        ;
    sign = (s[i] == '-') ? -1 : 1;

    if (s[i] == '-' || s[i] == '+')
        i++;
    
    for (val = 0.0; isdigit(s[i]); i++)
    {
        val = val * 10 + (s[i] - '0');
    }

    if (s[i] == '.')
    {
        i++;
    }

    for (power = 1.0; isdigit(s[i]); i++)
    {
        val = val * 10 + (s[i] - '0');
        power *= 10;
    }

    if (s[i] == 'e' || s[i] == 'E')
    {
        i++;
    }

    powersign = (s[i] == '-') ? -1 : 1;

    if (s[i] == '-' || s[i] == '+')
        i++;

    for (exponent = 0.0; isdigit(s[i]); i++)
    {
        exponent = exponent * 10 + (s[i] - '0');
    } 
    val = val * pow(10.0, (double)powersign*exponent);

    return (sign * val / power);
}