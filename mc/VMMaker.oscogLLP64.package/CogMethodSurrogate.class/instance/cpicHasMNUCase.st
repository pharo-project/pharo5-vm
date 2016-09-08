accessing
cpicHasMNUCase
	"Answer if the receiver has an MNU case."
	<inline: true>

	^SistaV1BytecodeSet
		ifTrue: [self cpicHasMNUCaseOrCMIsFullBlock and: [self cmType = CMClosedPIC]]
		ifFalse: [self cpicHasMNUCaseOrCMIsFullBlock]