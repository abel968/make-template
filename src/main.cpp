#include "hi.hpp"
extern "C"
{
#include "hello.hpp"
}
#include "imgshow.h"
int main()
{
  hi();
  hello();
  show();
  return 0;
}
