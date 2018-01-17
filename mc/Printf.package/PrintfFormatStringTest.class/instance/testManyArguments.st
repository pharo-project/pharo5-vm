as yet unclassified
testManyArguments

	self assert: 'Here is a long string "hello world" and the same shortened "hello w       " with left flush.
The new line has a number "42.0" and a 0-padded limited precision one "0000042.12345".' equals: ('Here is a %s string "%s" and the same shortened "%-14.7s" with left flush.\nThe new line has a number "%e" and a 0-padded limited precision one "%013.5e".'
		printf: #('long' 'hello world' 'hello world' 42.0 42.1234567))