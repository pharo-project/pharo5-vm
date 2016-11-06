testing
isQuick: operand
	<var: #operand type: #'usqIntptr_t'>
	^operand signedIntFromLong64 between: -128 and: 127