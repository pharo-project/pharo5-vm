as yet unclassified
testOneString

	self assert: 'Here is a string "hello world".' equals: ('Here is a string "%s".' printf: 'hello world')