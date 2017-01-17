C translation
generateDivide: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| rcvr arg divisor check |
	rcvr := msgNode receiver.
	arg := msgNode args first.
	check :=	false "If you need to check the validity of divides that had been implemented by signed shifts, change this to true..."
				and: [arg isConstant
				and: [(divisor := arg value) isInteger
				and: [divisor isPowerOfTwo
				and: [divisor > 0
				and: [divisor <= (1 bitShift: 31)]]]]].
	check ifTrue:
		[(headerFiles includes: '"sqAssert.h"') ifFalse:
			[self addHeaderFile: '"sqAssert.h"'].
		aStream nextPut: $(; nextPutAll: 'assert(((sqInt) '.
		 self emitCExpression: rcvr on: aStream.
		 aStream nextPutAll: ' >> ', (divisor log: 2) asInteger printString.
		 aStream nextPutAll: ') == ('.
		 self emitCExpression: rcvr on: aStream.
		aStream nextPutAll: ' / '.
		self emitCExpression: msgNode args first on: aStream.
		aStream nextPutAll: ')),'].
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPutAll: ' / '.
	self emitCExpression: msgNode args first on: aStream.
	check ifTrue:
		[aStream nextPut: $)]