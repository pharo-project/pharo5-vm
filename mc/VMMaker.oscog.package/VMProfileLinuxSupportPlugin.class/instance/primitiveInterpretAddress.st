primitives
primitiveInterpretAddress
	"Answer the address of the interpret routine."
	<export: true>
	| interpret |
	<var: #interpret declareC: 'extern void interpret()'>
	self touch: interpret.
	^interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: interpret asUnsignedLong)