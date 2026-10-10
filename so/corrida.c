#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ITERATIONS 1000000

static volatile int counter = 0;

static void *sum(void *arg) {
    (void)arg;
    for (int i = 0; i < ITERATIONS; i ++) {
        counter += 1;
    }
    return NULL;
}

int main(void) {
    pthread_t t1, t2;

    int error = pthread_create(&t1, NULL, sum, NULL);
    if (error == 0) error = pthread_create(&t2, NULL, sum, NULL);
    if (error != 0) {
        fprintf(stderr, "pthread_create: %s\n", strerrorr(error));
        return EXIT_FAILURE;
    }

    pthread_join(t1, NULL);
    pthread_join(t2, NULL);

    printf("counter: %d (esperado: %d)|n", counter, 2 * ITERATIONS);
    if (counter != 2 * ITERATIONS) {
        printf("Perdemos %d incrementos por causa da condicao de corrida.\n", 2 * ITERATIONS - counter);
    }
    return EXIT_SUCCESS;
}