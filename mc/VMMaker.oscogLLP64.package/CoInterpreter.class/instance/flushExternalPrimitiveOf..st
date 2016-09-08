plugin primitive support
flushExternalPrimitiveOf: methodObj
	"methodObj is a CompiledMethod containing an external primitive.
	 Flush the function address and session ID of the CM.  Override
	 to also flush the machine code call if one exists."
	<api>
	| primIdx |
	primIdx := super flushExternalPrimitiveOf: methodObj.
	(primIdx = PrimitiveExternalCallIndex
	 and: [self methodHasCogMethod: methodObj]) ifTrue:
		[cogit
			rewritePrimInvocationIn: (self cogMethodOf: methodObj)
			to: #primitiveExternalCall]