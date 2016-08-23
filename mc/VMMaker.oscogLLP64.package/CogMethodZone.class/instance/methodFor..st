jit - api
methodFor: address
	<api>
	<returnTypeC: #'CogMethod *'>
	<var: #address type: #'void *'>
	| cogMethod nextMethod |
	<var: #cogMethod type: #'CogMethod *'>
	<var: #nextMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony
	 and: [cogMethod asUnsignedInteger <= address asUnsignedInteger]] whileTrue:
		[nextMethod := self methodAfter: cogMethod.
		 nextMethod = cogMethod ifTrue:
			[^0].
		 (address asUnsignedInteger >= cogMethod asUnsignedInteger
		  and: [address asUnsignedInteger < nextMethod asUnsignedInteger]) ifTrue:
			[^cogMethod].
		 cogMethod := nextMethod].
	^0