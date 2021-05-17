#include <mpi.h>
#include <stdio.h>

int world_size; // número total de processos
int world_rank; // ID (rank) do processo
double *A = nullptr;
int N = 5;

int main(void) {

    MPI_Init(NULL, NULL); // Inicializa o MPI
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    A = new double[N];
    for (int i = 0; i < N; i++) {
        A[i] = (double) (i + world_rank * 10);
        printf(" Before Bcast, A(%d)[%d] =  %8.4f\n", world_rank, i, A[i]);
    }
    printf("\n");
    int tam = int(N / world_size);

    for (int i = 0; i < world_size - 1; i++) {
        MPI_Bcast(&A[i * tam], tam, MPI_DOUBLE, i, MPI_COMM_WORLD);
    }
    // MPI_Bcast do último processo
    MPI_Bcast(&A[(world_size - 1) * tam], N - (world_size - 1) * tam, MPI_DOUBLE, world_size - 1,
              MPI_COMM_WORLD);

    for (int i = 0; i < N; i++) {
        printf(" After Bcast , A(%d)[%d] =  %8.4f\n", world_rank, i, A[i]);
    }
    printf("\n");
    MPI_Finalize();
    return 0;
}