young referers
addAllToYoungReferrers
	<api>
	<returnTypeC: #void>
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod < self limitZony] whileTrue:
		[(cogMethod cmType = CMMethod
		  or: [cogMethod cmType = CMOpenPIC]) ifTrue:
			[self ensureInYoungReferrers: cogMethod].
		 cogMethod := self methodAfter: cogMethod]