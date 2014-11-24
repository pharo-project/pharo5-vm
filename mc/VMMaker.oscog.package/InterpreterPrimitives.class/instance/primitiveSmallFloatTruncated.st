arithmetic float primitives
primitiveSmallFloatTruncated
	<option: #Spur64BitMemoryManager>
	| rcvr trunc |
	<var: #rcvr type: #double>
	<var: #trunc type: #double>
	rcvr := self smallFloatValueOf: self stackTop.
	self cCode: [self mod: rcvr f: (self addressOf: trunc)]
		inSmalltalk: [trunc := rcvr truncated].
	(trunc between: SmallInteger minVal asFloat and: SmallInteger maxVal asFloat)
		ifTrue: [self pop: 1 thenPushInteger: trunc asInteger]
		ifFalse: [self primitiveFail]