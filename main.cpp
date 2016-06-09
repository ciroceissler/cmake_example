#include <stdio.h>
#include <fftw3.h>
#include <systemc.h>
#include <omp.h>

#define N 10

int sc_main(int argc, char* argv[]) {
  int i;
  int threadID = 0;

  fftw_complex in[N], out[N];
  fftw_plan p;

  printf("hello world!\n\n");

#ifdef _SIM_DDLMS_
  printf("define _SIM_DDLMS_!\n\n");
#endif 

  #pragma omp parallel for private(i, threadID)
  for(i = 0; i < 16; i++ ) {
    threadID = omp_get_thread_num();

    #pragma omp critical
    {
      printf("Thread %d reporting\n", threadID);
    }
  }

  return 0;
}
