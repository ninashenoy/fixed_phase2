parser: lex.yy.c y.tab.c
	g++ -std=c++11 -o parser y.tab.c lex.yy.c -lfl

y.tab.c: mini_l.y
	bison -v -d --file-prefix=y mini_l.y

lex.yy.c: mini_l.lex
	flex mini_l.lex

clean:
	rm -rf lex.yy.c y.tab.* y.output *.o  parser
