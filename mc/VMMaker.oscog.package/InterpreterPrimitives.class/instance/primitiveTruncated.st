arithmetic float primitives
primitiveTruncated
	"N.B. IMO we should be able to assume the receiver is a float because this primitive is specific to floats. eem 2/13/2017"
	| rcvr trunc |
	<var: #rcvr type: #double>
	<var: #trunc type: #double>
	rcvr := self stackFloatValue: 0.
	self successful ifTrue:
		[self cCode: [self mod: rcvr f: (self addressOf: trunc)]
			inSmalltalk: [trunc := rcvr = rcvr
									ifTrue: [rcvr truncated]
									ifFalse: [Float nan]].
		 (trunc between: objectMemory minSmallInteger asFloat and: objectMemory maxSmallInteger asFloat)
			ifTrue: [self stackTopPut: (objectMemory integerObjectOf: trunc asInteger)]
			ifFalse: [self primitiveFail]]