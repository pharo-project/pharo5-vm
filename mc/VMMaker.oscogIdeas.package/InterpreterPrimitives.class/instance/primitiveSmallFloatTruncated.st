arithmetic float primitives
primitiveSmallFloatTruncated
	<option: #Spur64BitMemoryManager>
	| rcvr trunc |
	<var: #rcvr type: #double>
	<var: #trunc type: #double>
	rcvr := objectMemory smallFloatValueOf: self stackTop.
	self cCode: [self mod: rcvr f: (self addressOf: trunc)]
		inSmalltalk: [trunc := rcvr truncated].
	(trunc between: objectMemory minSmallInteger asFloat and: objectMemory maxSmallInteger asFloat)
		ifTrue: [self stackTopPut: (objectMemory integerObjectOf: trunc asInteger)]
		ifFalse: [self primitiveFail]