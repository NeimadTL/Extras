#include <stdio.h>
#include <dirent.h>

int main (int argc, char *argv[])
{

  DIR *dirp;
  struct dirent *dirent;

  if (argc == 1) dirp = opendir(".");
  else dirp = opendir(argv[1]);
  
  if (dirp == NULL) { printf("No such file or directory '.'\n"); return 2; }

  while ((dirent = readdir(dirp)) != NULL) {
    printf("%s ", dirent->d_name);
    printf("size: %d\n", dirent->d_reclen);
  }
  closedir(dirp);

  return 0;
}
