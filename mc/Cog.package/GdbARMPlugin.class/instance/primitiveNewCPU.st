primitives
primitiveNewCPU
	| cpu |
	<var: #cpu type: 'void *'>
	self primitive: #primitiveNewCPU parameters: #().

	cpu := self cCode: 'newCPU()' inSmalltalk: [0].
	cpu = 0 ifTrue:
		[^interpreterProxy primitiveFail].
	interpreterProxy
		pop: 1
		thenPush: (interpreterProxy positiveMachineIntegerFor:
										(self cCoerceSimple: cpu
											to: 'usqIntptr_t'))