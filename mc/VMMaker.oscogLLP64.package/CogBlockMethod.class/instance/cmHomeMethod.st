accessing
cmHomeMethod
	^SistaV1BytecodeSet
		ifTrue: [self cmIsFullBlock
					ifTrue: [self cCoerceSimple: self to: #'CogMethod *']
					ifFalse: [self cCoerceSimple: self asUnsignedInteger - self homeOffset to: #'CogMethod *']]
		ifFalse: [self cCoerceSimple: self asUnsignedInteger - self homeOffset to: #'CogMethod *']