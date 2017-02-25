accessing
addFunctionAttribute: aString
	functionAttributes := functionAttributes
							ifNil: [aString]
							ifNotNil: [functionAttributes, ' ', aString]