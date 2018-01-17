as yet unclassified
testOneExponentWithLength

	self assert: 'Here is a string "0000042.12345".' equals: ('Here is a string "%013.5e".' printf: 42.1234567).