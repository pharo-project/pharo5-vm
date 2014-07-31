span functions
squeakV3orSistaV1: descriptor Num: pc Push: nExts Nils: aMethodObj
	<var: #descriptor type: #'BytecodeDescriptor *'>
	| numNils |
	(numNils := self v3: descriptor Num: pc Push: nExts Nils: aMethodObj) > 0 ifTrue:
		[^numNils].
	^self sistaV1: descriptor Num: pc Push: nExts Nils: aMethodObj