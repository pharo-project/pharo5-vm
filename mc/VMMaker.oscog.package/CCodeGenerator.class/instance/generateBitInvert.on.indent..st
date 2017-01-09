C translation
generateBitInvert: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream.
	 If the selector is bitInvert32 then cast to unsigned int to ensure
	 a 32-bit value on 64-bit platforms."

	| castToUnsignedInt castToUnsignedLong castToUnsignedLongLong |
	(castToUnsignedInt := msgNode selector = #bitInvert32) ifTrue:
		[aStream nextPutAll: '(unsigned int)'].
	aStream nextPut: $~.
	(castToUnsignedLong := msgNode selector = #bitInvert64 and: [vmClass notNil and: [vmClass objectMemoryClass wordSize = 8]]) ifTrue:
		[aStream nextPutAll: '(usqIntptr_t)'].
	(castToUnsignedLongLong := msgNode selector = #bitInvert64 and: [vmClass isNil or: [vmClass objectMemoryClass wordSize = 4]]) ifTrue:
		[aStream nextPutAll: '(unsigned long long)'].
	self assert: castToUnsignedInt asBit + castToUnsignedLong asBit + castToUnsignedLongLong asBit <= 1. "We should only do a single cast"
	self emitCExpression: msgNode receiver on: aStream