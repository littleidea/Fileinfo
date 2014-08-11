#include <stdio.h>

int main(void)
{
    int i;
    for(i = 1; i < 100; i++){
        if((i % 3) == 0 && (i % 5) == 0){
            fprintf(stdout, "Fizzbuzz\n");
            continue;
        }
        else if((i % 3) == 0){
            fprintf(stdout, "Fizz\n");
            continue;
        }else if((i % 5) == 0){
            fprintf(stdout, "Buzz\n");
            continue;
        }else
            fprintf(stdout, "%d\n", i);
    }
    return 0;
}
