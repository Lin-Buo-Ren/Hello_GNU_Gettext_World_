/* For program exit status, etc. */
#include <stdlib.h>

/* For console output routines, etc. */
#include <stdio.h>

/* For Gettext package id */
#include <software-config.h>

/* For locale-related definitions and routines */
#include <locale.h>

/* For executable relocation support */
#include <binreloc.h>

/* For string manipulate support */
#include <string.h>

/* For max path limits */
#include <limits.h>

/* GNU Gettext I18N framework support */
#ifndef GNU_GETTEXT_I18N_READY
    /* GNU Gettext I18N framework support(preparation phase) */
    #define _(String) (String)
    #define N_(String) String
    #define textdomain(Domain)
    #define bindtextdomain(Package, Directory)

#else
    /* GNU Gettext I18N framework support(deployed phase) */
    #include <libintl.h>
    #define _(String) gettext (String)
    #define gettext_noop(String) String
    #define N_(String) gettext_noop (String)

#endif

int main(int command_line_argument_count, char * command_line_argument_string_vector[]){
	/* Initialize BinReloc */{
		BrInitError binreloc_init_error_status;
		
		printf("[DEBUG] Initializing BinReloc...");
		if(br_init(&binreloc_init_error_status)){
			printf("done.\n");
			printf ("[DEBUG] The full path of this executable is: %s\n", br_find_exe ("<Executable path can't be found>"));
		}else{
			printf("\n[ERROR] BinReloc initilization failed!  I18N may not work because of this...\n");
			printf("[ERROR] Initilization error status=%d\n", binreloc_init_error_status);
		}
	}
	
	/* Initialize GNU Gettext locale data */{
		char executable_directory_path[PATH_MAX];
		char translation_directory_path[PATH_MAX];
		strcpy(executable_directory_path, br_dirname(br_find_exe ("<Executable path can't be found>")));
		
		/* generate the correct translation_path */
		strcpy(translation_directory_path, executable_directory_path);
		strcat(translation_directory_path, "/"SOFTWARE_PATH_CONVERSION_FROM_EXECUTABLE_DIRECTORY_TO_RELEASE_ROOT_DIRECTORY"/Translations");
		
		printf("[DEBUG] LC_ALL has been set to %s.\n", setlocale(LC_ALL, ""));
		/* printf("[DEBUG] Current message catalogs base directory of Gettext translation is: %s.\n", bindtextdomain(SOFTWARE_NAME, SOFTWARE_PATH_CONVERSION_FROM_EXECUTABLE_DIRECTORY_TO_RELEASE_ROOT_DIRECTORY"Translations")); */
		printf("[DEBUG] Current message catalogs base directory of Gettext translation is: %s.\n", bindtextdomain(SOFTWARE_NAME, translation_directory_path));
		printf("[DEBUG] Current message domain: %s.\n", textdomain(SOFTWARE_NAME));
	}
	
	printf(_("Hello GNU Gettext world from C programming language!\n"));
	return EXIT_SUCCESS;
}
