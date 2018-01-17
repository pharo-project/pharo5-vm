as yet unclassified
testOneIntegerWithLength

	self assert: 'Here is a string "0000042".' equals: ('Here is a string "%07.7d".' printf: 42).