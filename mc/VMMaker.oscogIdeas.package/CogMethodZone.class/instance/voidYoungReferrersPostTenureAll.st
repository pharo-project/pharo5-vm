jit - api
voidYoungReferrersPostTenureAll
	<var: #cogMethod type: #'CogMethod *'>
	| pointer cogMethod |
	<var: #pointer type: #usqInt>
	<var: #cogMethod type: #'CogMethod *'>
	self assert: youngReferrers <= limitAddress.
	pointer := youngReferrers.
	[pointer < limitAddress] whileTrue:
		[cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: pointer) to: #'CogMethod *'.
		 cogMethod cmType ~= CMFree ifTrue:
			[cogMethod cmRefersToYoung: false].
		 pointer := pointer + objectMemory wordSize].
	youngReferrers := limitAddress