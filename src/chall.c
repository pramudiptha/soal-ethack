#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char flag_half[50];

int main(){
    setvbuf(stdout, NULL, _IONBF, 0);

    char name[8];
    char order[16];
    char another_order[32];
    int hack_me = 0;
    
    FILE* fp = fopen("./flag_incomplete.txt", "r");

    fscanf(fp, "%s", flag_half);
    fclose(fp);

    puts("What is your name?");
    read(0, name, 8);
    puts("What do you want to order?");
    read(0, order, 16);

    puts("Let me repeat your order");
    printf(order);

    puts("Any other order?");
    scanf("%s", another_order);
    puts("Let me repeat your order");
    printf(another_order, &hack_me);

    if (hack_me == 69) {
        system("cat other_half.txt");
    }

    return 0;
}
