C translation
generateIntegerObjectOf: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."
	| expr mustCastToUnsigned type typeIsUnsigned |
	expr := msgNode args first.
	aStream nextPutAll: '(('.
	"Note that the default type of an integer constant in C is int.  Hence we /must/
	 cast expression to long if in the 64-bit world, since e.g. in 64-bits
		(int)(16r1FFFFF << 3) = (int)16rFFFFFFF8 = -8
	 whereas
		(long)(16r1FFFFF << 3) = (long) 16rFFFFFFF8 = 4294967288."
	type := self typeFor: expr in: currentMethod.
	typeIsUnsigned := type first = $u.
	mustCastToUnsigned := typeIsUnsigned not
		or: [(self sizeOfIntegralCType: type) < (self sizeOfIntegralCType: #usqInt)].
	mustCastToUnsigned ifTrue:
		[aStream nextPutAll: '(usqInt)'].
	self emitCExpression: expr on: aStream.
	aStream
		nextPutAll: ' << ';
		print: vmClass objectMemoryClass numSmallIntegerTagBits;
		nextPutAll: ') | 1)'