#include <math.h>
float foo(float f, float g) { return roundf(f); }
int main(void){ return (int) foo; }
