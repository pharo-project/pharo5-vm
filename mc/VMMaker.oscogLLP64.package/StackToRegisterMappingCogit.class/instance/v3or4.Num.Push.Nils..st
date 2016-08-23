span functions
v3or4: descriptor Num: pc Push: nExts Nils: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	^bytecodeSetOffset = 0
		ifTrue: [self v3: descriptor Num: pc Push: nExts Nils: aMethodObj]
		ifFalse: [self v4: descriptor Num: pc Push: nExts Nils: aMethodObj]