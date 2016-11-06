testing
isQuick: operand
	<var: #operand type: #'usqIntptr_t'>
	^operand signedIntFromLong between: -128 and: 127