system primitives
primitiveNSInvocationFree: pointer
	|  pointerToFree |
	self primitive: 'primitiveNSInvocationFree'
		parameters: #(Oop).
	self var: 'pointerToFree' declareC: 'void* pointerToFree'.

	pointerToFree := self cCoerce: (interpreterProxy positive64BitValueOf: pointer) to: 'void *'.
	interpreterProxy failed ifTrue: [^nil].
	self cCode: 'free((void*)pointerToFree)'.
	self touch: pointer.
	^self