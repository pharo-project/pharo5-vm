as yet unclassified
testOnePrintString

	self assert: 'Here is a point "3@4".' equals: ('Here is a point "%P".' printf: 3@4)