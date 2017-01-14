jit - api
numMethodsOfType: cogMethodType
	<api>
	| n cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	n := 0.
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[cogMethod cmType = cogMethodType ifTrue:
			[n := n + 1].
		 cogMethod := self methodAfter: cogMethod].
	^n