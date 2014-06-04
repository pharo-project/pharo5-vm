testing
isQuick: operand
	<var: #operand type: #'unsigned long'>
	^operand signedIntFromLong between: -128 and: 127