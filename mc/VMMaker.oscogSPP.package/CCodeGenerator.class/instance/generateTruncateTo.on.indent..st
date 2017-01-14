C translation
generateTruncateTo: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| arg |
	(self isConstantNode: msgNode args first valueInto: [:a| arg := a]) ifFalse:
		[self error: 'can''t find method for inlining truncateTo:'].
	self assert: (arg isInteger and: [arg isPowerOfTwo]).
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' & ~'; print: arg - 1; nextPut: $)