generate machine code
computeSizeOfArithCqR
	"With CqR we assume constants are 32-bits or less."
	<inline: true>
	^(self isQuick: (operands at: 0))
		ifTrue: [4]
		ifFalse: [(self concreteRegister: (operands at: 1)) = RAX
					ifTrue: [6]
					ifFalse: [7]]