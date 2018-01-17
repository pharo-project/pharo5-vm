as yet unclassified
testOneExponent

	self assert: 'Here is a number "42.0".' equals: ('Here is a number "%e".' printf: 42.0).