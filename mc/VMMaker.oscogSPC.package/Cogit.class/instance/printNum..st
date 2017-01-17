printing
printNum: n
	<cmacro: '(n) printf("%ld", (long) n)'>
	coInterpreter transcript printNum: n