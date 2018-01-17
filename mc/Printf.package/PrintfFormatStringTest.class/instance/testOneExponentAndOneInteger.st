as yet unclassified
testOneExponentAndOneInteger

	self assert: 'Here is a float "42.0" and an integer "42".' equals: ('Here is a float "%e" and an integer "%d".' printf: #(42.0 42)).