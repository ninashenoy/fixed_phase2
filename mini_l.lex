%{
	#include <string>
	#include "y.tab.h"
	int lineCount = 1;
	int colCount = 0;
%}

DIGIT		[0-9]
ALPHA		[a-zA-Z]

%%

"function" return(FUNCTION);colCount+=yyleng;
"beginparams" return(BEGIN_PARAMS);colCount+=yyleng;
"endparams" return(END_PARAMS);colCount+=yyleng;
"beginlocals" return(BEGIN_LOCALS);colCount+=yyleng;
"endlocals" return(END_LOCALS);colCount+=yyleng;
"beginbody" return(BEGIN_BODY);colCount+=yyleng;
"endbody" return(END_BODY);colCount+=yyleng;
"integer" return(INTEGER);colCount+=yyleng;
"array" return(ARRAY);colCount+=yyleng;
"of" return(OF);colCount+=yyleng;
"if" return(IF);colCount+=yyleng;
"then" return(THEN);colCount+=yyleng;
"endif" return(ENDIF);colCount+=yyleng;
"else" return(ELSE);colCount+=yyleng;
"while" return(WHILE);colCount+=yyleng;
"do" return(DO);colCount+=yyleng;
"beginloop" return(BEGINLOOP);colCount+=yyleng;
"endloop" return(ENDLOOP);colCount+=yyleng;
"read" return(READ);colCount+=yyleng;
"write" return(WRITE);colCount+=yyleng;
"and" return(AND);colCount+=yyleng;
"or" return(OR);colCount+=yyleng;
"not" return(NOT);colCount+=yyleng;
"true" return(TRUE);colCount+=yyleng;
"false" return(FALSE);colCount+=yyleng;
"return" return(RETURN);colCount+=yyleng;
"continue" return(CONTINUE);colCount+=yyleng;


"-" return(SUB);colCount+=yyleng;
"+" return(ADD);colCount+=yyleng;
"*" return(MULT);colCount+=yyleng;
"/" return(DIV);colCount+=yyleng;
"%" return(MOD);colCount+=yyleng;

"==" return(EQ);colCount+=yyleng;
"<>" return(NEQ);colCount+=yyleng;
"<" return(LT);colCount+=yyleng;
">" return(GT);colCount+=yyleng;
"<=" return(LTE);colCount+=yyleng;
">=" return(GTE);colCount+=yyleng;

[a-zA-Z]([a-zA-Z]|[0-9]+|"_"([a-zA-Z]|[0-9]+))*	{yylval.ident_val = strdup(yytext); return (IDENT); colCount += yyleng;}
[0-9]+													{yylval.num_val = atoi(yytext); return (NUMBER); colCount += yyleng;}

";" return(SEMICOLON);colCount+=yyleng;
":" return(COLON);colCount+=yyleng;
"," return(COMMA);colCount+=yyleng;
"(" return(L_PAREN);colCount+=yyleng;
")" return(R_PAREN);colCount+=yyleng;
"[" return(L_SQUARE_BRACKET);colCount+=yyleng;
"]" return(R_SQUARE_BRACKET);colCount+=yyleng;
":=" return(ASSIGN);colCount+=yyleng;

"\n"    lineCount++;colCount=0;    
[\t|" "]      /* ignore white space */colCount+=yyleng;
"##"[^\n]*"\n"	/* ignore comment */colCount=0;

([0-9]+|"_")([a-zA-Z]|[0-9]+|"_"([a-zA-Z]|[0-9]+))+			printf("ERROR at line %d, column %d: identifier \"%s\" must begin with a letter\n", lineCount,colCount, yytext);exit(0);
[a-zA-Z]([a-zA-Z]|[0-9]+|"_")*"_"				printf("ERROR at line %d, column %d: identifier \"%s\" cannot end with an underscore\n", lineCount, colCount, yytext);exit(0);
.											{printf("ERROR at line %d, column %d: unrecognized symbol \"%s\"\n", lineCount, colCount, yytext); /*exit(0)*/;}


%%