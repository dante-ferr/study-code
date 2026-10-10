#include <pthread.h>
#include <stdatomic.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ITERATIONS 10000
static atomic_int turn = 0;
static atomic_bool intereseted[2];
static char cr[16];
static int contador;

static void enter_region(int eu) {
    int outro = 1 - eu;
    atomic_store(&intereseted[eu], 1);
    atomic_store
}