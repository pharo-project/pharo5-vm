image save/restore
imageFormatVersion
	"Return a magic constant that changes when the image format changes.
	 Since the image reading code uses this to detect byte ordering, one
	 must avoid version numbers that are invariant under byte reversal."
	| isSpurFlag |
	isSpurFlag := objectMemory hasSpurMemoryManagerAPI ifTrue: [2r10000] ifFalse: [0].
	^(BytesPerWord = 4 ifTrue: [6505] ifFalse: [68003])
	  + isSpurFlag