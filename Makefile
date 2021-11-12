y.tab.c: mini_l.y
	bison -v -d --file-prefix=y mini_l.y

lex.yy.c: mini_l.lex
	flex mini_l.lex

parser: lex.yy.c y.tab.c
	g++ -std=c++11 -g -o my_compiler lex.yy.c mini_l.tab.c -lfl

clean:
	rm -rf lex.yy.c y.tab.* y.output *.o  parser

