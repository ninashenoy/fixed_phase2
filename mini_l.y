


%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string>
	#include <vector>

	using namespace std;
	extern int lineCount;
	extern int colCount;

	extern int yylex();
	extern int yyparse();
	extern FILE * yyin;

	void yyerror(const char *msg);
	vector<char*> list_of;
	string* NewTemp();

	int temp_count = 0;



%}


%union
{ 
	int num_val;
	char *ident_val;
}

%start prog_start

%left L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET
%left ADD SUB MULT DIV MOD EQ NEQ LT LTE GT GTE
%left AND OR

%right NOT ASSIGN

%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token CONTINUE
%token INTEGER ARRAY OF IF THEN ENDIF WHILE DO BEGINLOOP ENDLOOP BREAK READ WRITE TRUE FALSE RETURN

%token SEMICOLON COLON COMMA

%nonassoc ELSE
%token <ident_val> IDENT
%token <num_val> NUMBER

%define parse.error verbose //prints error messages

%%

prog_start:
  functions {printf("prog_start -> functions\n");}
;

functions:
  function functions {printf("functions -> function functions\n");} //list of functions
  | {printf("functions -> epsilon\n");}
	
;

function:
	FUNCTION ident SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY {
		printf("function -> FUNCTION ident SEMICOLON BEGIN_PARAMS declarations END_PARAMS BEGIN_LOCALS declarations END_LOCALS BEGIN_BODY statements END_BODY\n");}
;

declarations:
  declaration SEMICOLON declarations {printf("declarations -> declaration SEMICOLON declarations\n");}
  | {printf("declarations -> epsilon\n");}
;

declaration:
	identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER { printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET number R_SQUARE_BRACKET OF INTEGER\n");}
	| identifiers COLON INTEGER 	{printf("declaration -> identifiers COLON INTEGER\n");}
	| identifiers error INTEGER 	{yyerror("syntax error, invalid declaration"); yyerrok;}
;

identifiers:
	ident COMMA identifiers 		{printf("identifiers -> ident COMMA identifiers\n");}
	| ident 						{printf("identifiers -> ident\n");}
	| {printf("identifiers -> epsilon\n");}

;

ident:
	IDENT {printf("ident -> IDENT %s\n", $1);}
;

number:
	NUMBER {printf("number -> NUMBER %d\n", $1);}
;

statements:
	statement statements {printf("statements -> statement SEMICOLON statements\n");}
	| {printf("statements -> epsilon\n");}

;

statement:
	assign_statement SEMICOLON		{printf("statement -> assign_statement SEMICOLON\n");}
	| if_statement SEMICOLON			{printf("statement -> if_statement SEMICOLON\n");}
	| IF boolexp THEN statements ENDIF {printf("if_statement -> IF boolexp THEN statements ENDIF\n");}
	| do_statement SEMICOLON 		{printf("statement -> do_statement SEMICOLON\n");}
	| while_statement SEMICOLON		{printf("statement -> while_statement SEMICOLON\n");}
	| READ vars SEMICOLON			{printf("statement -> READ vars SEMICOLON\n");}
	| WRITE vars SEMICOLON			{printf("statement -> WRITE vars SEMICOLON\n");}
	| BREAK SEMICOLON				{printf("statement -> BREAK SEMICOLON\n");}
	| RETURN expr SEMICOLON 			{printf("statement -> RETURN exp SEMICOLON\n");}
	| CONTINUE {printf("statement -> CONTINUE\n");}
;

assign_statement:
	var ASSIGN expr					{printf("statement -> var ASSIGN exp SEMICOLON\n");}
	| var error expr				{yyerror("syntax error, expected assignment"); yyerrok;}
;

if_statement:
	//IF boolexp THEN statements ENDIF {printf("if_statement -> IF boolexp THEN statements ENDIF\n");}
	| IF boolexp THEN statements ELSE statements ENDIF {printf("if_statement -> IF boolexp THEN statements ELSE statements ENDIF\n");}
;

while_statement:
	WHILE boolexp BEGINLOOP statements ENDLOOP {printf("while_statement -> WHILE boolexp BEGINLOOP statements ENDLOOP\n");}
;

do_statement:
	DO BEGINLOOP statements ENDLOOP WHILE boolexp {printf("do_statement -> DO BEGINLOOP statements ENDLOOP WHILE boolexp\n");}
;

boolexp:
	relation_and_expr relation_and_exprs 	{printf("boolexp -> relation_and_expr relation_and_exprs\n");}
;

relation_and_expr:
	relationexpr relation_exprs		{printf("relation_and_expr -> relationexpr relationexprs\n");}
;

relation_and_exprs:
	{printf("relation_and_exprs -> epsilon\n");}
	| OR relation_and_expr relation_and_exprs {printf("relation_and_exprs -> OR relation_and_exp relation_and_exprs\n");}
;

relation_exprs:
	{printf("relationexprs -> epsilon\n");}
	| AND relationexpr relation_exprs 	{printf("relationexprs -> AND relationexpr relationexprs\n");}
;

relationexpr:
	NOT relationexpr 				{printf("relationexpr -> NOT relationexp\n");}
	| expr comparison expr					{printf("relationexp -> exp comparison exp\n");}
	| TRUE 							{printf("relationexpr -> TRUE\n");}
	| FALSE 						{printf("relationexpr -> FALSE\n");}
	| L_PAREN boolexp R_PAREN 		{printf("relationexpr -> L_PAREN boolexp R_PAREN\n");}
	| L_PAREN error R_PAREN			{yyerror("syntax error, invalid expression"); yyerrok;}
;

comparison:
	EQ 								{printf("comparison -> EQ\n");}
	| NEQ 							{printf("comparison -> NEQ\n");}
	| LT 							{printf("comparison -> LT\n");}
	| LTE 							{printf("comparison -> LTE\n");}
	| GT 							{printf("comparison -> GT\n");}
	| GTE 							{printf("comparison -> GTE\n");}
;

exps:
	{printf("exps -> epsilon\n");}
	| expr							{printf("exprs -> expr\n");}
	| expr COMMA exps				{printf("exprs -> expr COMMA exps\n");}
;

expr:
	multexpr multexprs				{printf("expr -> multexpr multexprs\n");}
;

multexprs:
	{printf("multexps -> epsilon\n");}
	| ADD multexpr multexprs 			{printf("multexprs -> ADD multexrp multexprs\n");}
	| SUB multexpr multexprs 			{printf("multexprs -> SUB multexpr multexprs\n");}
;

multexpr:
	term terms						{printf("multexpr -> term terms\n");}
;

terms:
	MULT term terms 				{printf("terms -> MULT term terms\n");}
	| DIV term terms 				{printf("terms -> DIV term terms\n");}
	| MOD term terms 				{printf("terms -> MOD term terms\n");}
	| {printf("terms -> epsilon\n");}

;

term:
	neg_term					{printf("term -> neg_term\n");}
	| ident_term				{printf("term -> ident_term\n");}
;

neg_term:
	SUB neg_term {printf("neg_term -> SUB neg_term\n");}
	| var	{printf("neg_term -> var\n");}
	| number {printf("neg_term-> number\n");}
	| L_PAREN expr R_PAREN {printf("neg_term -> L_PAREN exp R_PAREN\n");}
;

ident_term:
	ident L_PAREN exps R_PAREN {printf("ident_term -> ident L_PAREN exps R_PAREN\n");}
;

vars:
	var COMMA vars {printf("vars -> var COMMA vars\n");}
	| var {printf("vars -> var\n");}
	| {printf("vars -> epsilon\n");}

;

var:
	ident {printf("var -> ident\n");}
	| ident L_SQUARE_BRACKET expr R_SQUARE_BRACKET 	{printf("var -> ident L_SQUARE_BRACKET exp R_SQUARE_BRACKET\n");}
	| ident L_SQUARE_BRACKET error R_SQUARE_BRACKET	{yyerror("syntax error!, invalid array expression"); yyerrok;}
;

%%

std::string* newTemp(){
	string* temp = new string("__temp__" + toString(temp_count++));
	return temp;
}

int main(int argc, char **argv) 
{
   yyparse();
   return 0;
}

void yyerror(const char *s) 
{
	printf("Error at line %d : %s\n", lineCount, s);
	exit(1); //exit after finding error
}
