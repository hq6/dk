#include <stdio.h>
#include <stdlib.h>
#include <string.h>

const char* help_text =
"USAGE\n"
"   dk hello-world-script\n\n"
"DESCRIPTION\n"
"   This is a test command to demonstrate how to write a script that is\n"
"   compatible with dk.";

/**
 * This program compiles into a binary that conforms to dk's requirements.
 */
int main(int argc, const char** argv){
  if (argc > 1 ) {
    if (strcmp(argv[1], "--summary") == 0) {
      printf("Say hello world\n");
      exit(0);
    }
    if (strcmp(argv[1], "--help") == 0) {
      printf("%s\n", help_text);
      exit(0);
    }
  }
  printf("hello dk from C\n");
}

