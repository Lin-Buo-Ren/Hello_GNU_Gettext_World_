#include <cstdlib>
#include <iostream>

/* GNU Gettext I18N framework support */
#ifndef GNU_GETTEXT_I18N_READY
    /* GNU Gettext I18N framework support(preparation phase) */
    #define _(String) (String)
    #define N_(String) String
    #define textdomain(Domain)
    #define bindtextdomain(Package, Directory)

#elif
    /* GNU Gettext I18N framework support(deployed phase) */
    #include <libintl.h>
    #define _(String) gettext (String)
    #define gettext_noop(String) String
    #define N_(String) gettext_noop (String)

#endif

int main(int command_line_argument_count, char * command_line_argument_string_vector[]){
    using std::cout;
    using std::endl;
    
    cout << "Hello GNU Gettext world from C++ programming language!" << endl;
    return EXIT_SUCCESS;
}
