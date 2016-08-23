testing
isQuick: operand
	<var: #operand type: #'usqInt'>
	^operand signedIntFromLong between: -128 and: 127