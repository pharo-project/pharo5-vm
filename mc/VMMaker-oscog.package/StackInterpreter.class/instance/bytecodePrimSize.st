common selector sends
bytecodePrimSize
	| rcvr sz isString isArray |
	self initPrimCall.
	rcvr := self internalStackTop.

	"Shortcut the mega-lookup for ByteString and Array, the two big consumers of cycles
	 here. Both of these have compact class indices and neither has any added fields."
      isString := self isInstanceOfClassByteString: rcvr.
	isString ifTrue:
		[sz := objectMemory lengthOf: rcvr.
		 self internalStackTopPut: (objectMemory integerObjectOf: sz).
		^self fetchNextBytecode].

      isArray := self isInstanceOfClassArray: rcvr.
	isArray ifTrue:
		[sz := objectMemory lengthOf: rcvr.
		 self internalStackTopPut: (objectMemory integerObjectOf: sz).
		^self fetchNextBytecode].

	messageSelector := self specialSelector: 18.
	argumentCount := 0.
	self normalSend