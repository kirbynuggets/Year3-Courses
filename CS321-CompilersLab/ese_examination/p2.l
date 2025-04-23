%{
#include <stdio.h>
#include "y.tab.h"
%}

%%
"a"         { return A; }
"b"         { return B; }
"c"         { return C; }
"d"         { return D; }
[ \t\n]     { /* ignore whitespace */ }
.           { /* ignore unknown characters */ }
%%

int yywrap() {
    return 1;
}