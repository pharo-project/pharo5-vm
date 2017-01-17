arithmetic float primitives
primitiveTruncated 
	| rcvr trunc |
	<var: #rcvr type: #double>
	<var: #trunc type: #double>
	rcvr := self popFloat.
	self successful ifTrue:
		[self cCode: [self mod: rcvr f: (self addressOf: trunc)]
			inSmalltalk: [trunc := rcvr truncated].
		self success: (trunc between: objectMemory minSmallInteger asFloat and: objectMemory maxSmallInteger asFloat)].
	self successful
		ifTrue: [self pushInteger: trunc asInteger]
		ifFalse: [self unPop: 1]