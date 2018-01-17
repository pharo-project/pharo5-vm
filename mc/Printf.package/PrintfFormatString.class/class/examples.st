examples
examples
	self inform: ('Here is a string "%s".' printf: 'hello world').
	self inform: ('Here is a string "%s" and another shortened "%-14.7s".'
		printf: #('hello world' 'hello world')).

	self inform: ('Here is a number "%d".' printf: 42).
	self inform: ('Here is a string "%07.7d".' printf: 42).

	self inform: ('Here is a number "%e".' printf: 42.0).
	self inform: ('Here is a float "%e" and an integer "%d".' printf: #(42.0 42)).
	self inform: ('Here is a string "%013.5e".' printf: 42.1234567).

	self inform: ('Here is a %s string "%s" and the same shortened "%-14.7s" with left flush.\nThe new line has a number "%e" and a 0-padded limited precision one "%013.5e".'
		printf: ((Array with: 'long' with: 'hello world' with: 'hello world' with: 42.0) copyWith: 42.1234567)).