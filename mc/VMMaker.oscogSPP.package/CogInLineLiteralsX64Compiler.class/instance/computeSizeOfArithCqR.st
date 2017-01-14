generate machine code
computeSizeOfArithCqR
	"With CqR we assume constants are 32-bits or less."
	<inline: true>
	(self isQuick: (operands at: 0)) ifTrue:
		[^4].
	(self is32BitSignedImmediate: (operands at: 0)) ifTrue:
		[^(operands at: 1) = RAX ifTrue: [6] ifFalse: [7]].
	^10 "movabsq" + 3 "r op r"