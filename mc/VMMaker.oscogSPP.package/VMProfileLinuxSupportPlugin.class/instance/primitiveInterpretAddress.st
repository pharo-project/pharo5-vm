primitives
primitiveInterpretAddress
	"Answer the address of the interpret routine."
	<export: true>
	| interpret |
	<var: #interpret declareC: 'extern void interpret()'>
	^interpreterProxy methodReturnValue: (interpreterProxy positiveMachineIntegerFor: interpret asUnsignedIntegerPtr)