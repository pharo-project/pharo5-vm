compaction
compactPICsWithFreedTargets
	| cogMethod count |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	count := 0.
	[cogMethod < methodZone limitZony] whileTrue:
		[(cogMethod cmType = CMClosedPIC
		  and: [self cPICCompactAndIsNowEmpty: cogMethod]) ifTrue:
			[cogMethod cmType: CMFree].
		 cogMethod := methodZone methodAfter: cogMethod.
		 count := count + 1].
	self assert: count = methodZone numMethods