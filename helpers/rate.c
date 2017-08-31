#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<locale.h>
#include<wchar.h>

/* Get a number down to, at most, a specified number */
int reduce(int num, int max) {
    int retval = 0;
    while(num > max) {
        retval += num % max;
        num /= max;
    }
    if (retval > max) {
        retval = reduce(retval, max);
    }
    return retval;
}

int main(int argc, char** argv) {
    /* If not enough arguments were given, say so and exit with status 1 */
    if(argc < 3) {
        printf("Give me something to rate\n");
        exit(1);
    }

    int max;
    /*fprintf(stderr, "%s %d\n", argv[1], argv[1] == "o");*/
    /* If the first argument (after program name) is -o, give a number from 0-100.
     * Otherwise, give a number from 0-10 */
    if(strcmp(argv[1], "-o") == 0)
        max = 100;
    else
        max = 10;

    /* Add unicode support; convert whatever we're rating from char* to wchar_t* */
    setlocale(LC_ALL, "");
    wchar_t* warg = malloc((strlen(argv[2])+1) * sizeof(wchar_t));
    size_t len = mbstowcs(warg, argv[2], strlen(argv[2]) + 1);
    /* If something goes wrong in the char to wide char conversion, print an error and give
     * up */
    if(len == -1) {
        perror("shit's fucked");
        free(warg);
        exit(1);
    }

    /* "Rate" the string by adding up the value of each character */
    int rating = 0;
    int i = 0;
    for(i; i<len;i++) {
        rating += warg[i];
    }

    /* Reduce the rating so it's within the given number range, then print it */
    printf("%d", reduce(rating, max));
    /* Clean up and exit with code 0 (because all is well) */
    free(warg);
    return 0;
}
