span functions
squeakV3orSistaV1: descriptor Num: pc Push: nExts Nils: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	^bytecodeSetOffset = 0
		ifTrue: [self v3: descriptor Num: pc Push: nExts Nils: aMethodObj]
		ifFalse: [self sistaV1: descriptor Num: pc Push: nExts Nils: aMethodObj]