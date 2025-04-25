%{
#include <stdio.h>
#include "Question2_2201033.tab.h"
%}

%%
a       { return A; }
b       { return B; }
\n      { return NEWLINE; }
.       { /* Ignore other character */ }
%%

int yywrap() {
    return 1;
}