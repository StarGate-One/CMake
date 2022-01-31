/* A simple program that computes the square root of a number */
#include <cmath>
#include <iostream>
#include <string>

#include "TutorialConfig.h"

/* should we use the include MathFunctions header? */
#ifdef USE_MYMATH
  #include "MathFunctions.h"
#endif /* USE_MYMATH */

int main(int argc, char* argv[])
{
  if (argc < 2)
  {
    /* report version number */
    std::cout << argv[0] << " Version " << Tutorial_VERSION_MAJOR << "."
              << Tutorial_VERSION_MINOR << std::endl;
    std::cout << "Usage: " << argv[0] << " number" << std::endl;
    return 1;
  }

  /* convert input to double */
  const double inputValue = std::stod(argv[1]);

  /* which square root funtion show be used */
#ifdef USE_MYMATH
  std::cout << "Calculating using mysqrt function." << std::endl;
  const double outputValue = mysqrt(inputValue);
#else
  std::cout << "Calculating using sqrt function." << std::endl;
  const double outputValue = sqrt(inputValue);
#endif /* USE_MYMATH */

  std::cout << "The square root of " << inputValue << " is " << outputValue
            << "." << std::endl;
  return 0;
}
