%{
/*****     Declarations     *****/

#include <iostream>
using namespace std;

int total_lines = 0;        // total number of lines
int process_num = 0;        // processed number
string s;                   // lexeme type
void print_lex(string s);   // print function

%}

/*****     Definitions     *****/

%option noyywrap
DIGIT       [0-9]
ALPHA       [a-zA-Z]
ALPHANUM    [a-zA-z0-9]
HEX         [0-9ABCDEF]
BIN         [0|1]
OPERATOR    [\+\-\*/<>=]
SUFFIX      [\.com|\.net|\.edu]
KEYWORD     [PRINT|IF|PROC|THEN|ELSE|WHILE|END]

/*****     REG EX     *****/
%%


[ \t]                     {; // skipping white space
}

\n                      { total_lines++; // incrementing total_lines
}

%(.)*                     {; // skipping comments
}

[+-]?{DIGIT}+             { // check for integer
  print_lex("INTCONST");
}

[+-]?{DIGIT}+[.]{DIGIT}+  { // check for decimal
  print_lex("DECCONST");
}

[+-]?{DIGIT}+[.]{DIGIT}+[E][+|-]?{DIGIT}+  { // checking for scientific numbers
  print_lex("SCICONST");
}

\({DIGIT}{3}\){DIGIT}{3}\-{DIGIT}{4} {
  print_lex("PHCONST");
}

{DIGIT}{3}\-{DIGIT}{3}\-{DIGIT}{4} {
  print_lex("PHCONST");
}

{DIGIT}{3}\.{DIGIT}{3}\.{DIGIT}{4} {
  print_lex("PHCONST");
}

{HEX}+[H]                 { // checking for hexidecimals
  print_lex("HEXCONST");
}

{BIN}+[B]                 { // checking for binary numbers
  print_lex("BINCONST");
}

{OPERATOR}                { // checking for OPERATOR(s)
  print_lex("OPERATOR");
}

PRINT|IF|PROC|THEN|ELSE|WHILE|END { // checking for keywords
  print_lex("KEYWORD");
}

{ALPHA}+{ALPHANUM}*       { // checking for identifiers
  print_lex("IDENT");
}

\".*\"                    { // checking for string literals
  print_lex("STRCONST");
}

[\^]                      { // new line character add 1 to num_lines_process
  print_lex("?     ");

}

.                         { // default rule
  print_lex("?     ");
}

%%

/*****     CODE     *****/

void print_lex(string s){
  cout << "#" << process_num <<": TOKEN: "<< s <<"\tLEXEME: "<< yytext << endl;
  process_num ++; // increment 
}

main(){
  // lex through the input file
  yylex();
  cout << total_lines  << " lines processed." << endl;

  return 0;
}
