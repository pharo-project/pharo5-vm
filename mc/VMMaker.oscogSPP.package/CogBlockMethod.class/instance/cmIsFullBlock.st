accessing
cmIsFullBlock
	"Answer the value of cpicHasMNUCaseOrCMIsFullBlock"
	<inline: true>
	^SistaV1BytecodeSet
		ifTrue: [self cpicHasMNUCaseOrCMIsFullBlock]
		ifFalse: [false]