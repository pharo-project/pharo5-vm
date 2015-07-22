C translation
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	| expr castToSqint |
	expr := msgNode args first.
	aStream nextPutAll: '(('.
	"Note that the default type of an integer constant in C is int.  Hence we /must/
	 cast constants to long if in the 64-bit world, since e.g. in 64-bits
		(int)(16r1FFFFF << 3) = (int)16rFFFFFFF8 = -8
	 whereas
		(long)(16r1FFFFF << 3) = (long) 16rFFFFFFF8 = 4294967288."
	castToSqint := expr isConstant and: [vmClass isNil or: [vmClass objectMemoryClass wordSize = 8]].
	castToSqint ifTrue:
		[aStream nextPutAll: '(sqInt)'].
	self emitCExpression: expr on: aStream.
	aStream
		nextPutAll: ' << ';
		print: vmClass objectMemoryClass numSmallIntegerTagBits;
		nextPutAll: ') | 1)'