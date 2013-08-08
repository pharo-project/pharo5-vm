span functions
v4: descriptor Is: pc Push: nExts Nil: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	<inline: true>
	^descriptor generator == #genExtPushPseudoVariableOrOuterBytecode
	  and: [self assert: (objectMemory fetchByte: pc ofObject: aMethodObj) = 77.
			nExts = 1
	  and: [(objectMemory fetchByte: pc - 1 ofObject: aMethodObj) = 2]]