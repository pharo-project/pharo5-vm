translation support
cCoerceSimple: value to: cTypeString
	<doNotGenerate>
	cTypeString last == $* ifTrue:
		[cTypeString == #'CogMethod *' ifTrue:
			[^(value isInteger and: [value < 0])
				ifTrue: [value] "it's an error code; leave it be"
				ifFalse: [self cogMethodSurrogateAt: value asUnsignedInteger]].
		cTypeString == #'CogBlockMethod *' ifTrue:
			[^self cogBlockMethodSurrogateAt: value asUnsignedInteger].
		cTypeString == #'NSSendCache *' ifTrue:
			[^self nsSendCacheSurrogateAt: value asUnsignedInteger].
		(cTypeString == #'AbstractInstruction *'
		 and: [value isBehavior]) ifTrue:
			[^CogCompilerClass].
		cTypeString == #'StackPage *' ifTrue:
			[^coInterpreter stackPages surrogateAtAddress: value]].
	^super cCoerceSimple: value to: cTypeString