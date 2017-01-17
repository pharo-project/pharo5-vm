interpreter interface
setupColorMasks
	"WARNING: For WarpBlt w/ smoothing the source depth is wrong here!"
	| bits targetBits |
	bits := targetBits := 0.
	sourceDepth <= 8 ifTrue:[^nil].
	sourceDepth = 16 ifTrue:[bits := 5].
	sourceDepth = 32 ifTrue:[bits := 8].

	cmBitsPerColor = 0
		ifTrue:["Convert to destDepth"
				destDepth <= 8 ifTrue:[^nil].
				destDepth = 16 ifTrue:[targetBits := 5].
				destDepth = 32 ifTrue:[targetBits := 8]]
		ifFalse:[targetBits := cmBitsPerColor].

	self setupColorMasksFrom: bits to: targetBits