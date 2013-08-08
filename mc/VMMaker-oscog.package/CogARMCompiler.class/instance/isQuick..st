testing
isQuick: operand
	<var: #operand type: #'unsigned long'>
	^operand signedIntFromLong between: -33554432 and: 33554428