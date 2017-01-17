accessing
cmIsFullBlock
	"Answer the value of cpicHasMNUCaseOrCMIsFullBlock"

	^SistaV1BytecodeSet
		ifTrue: [self cpicHasMNUCaseOrCMIsFullBlock]
		ifFalse: [false]