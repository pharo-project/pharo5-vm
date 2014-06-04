garbage collection
followForwardedMethods
	<api>
	<option: #SpurObjectMemory>
	<var: #cogMethod type: #'CogMethod *'>
	| cogMethod freedPIC |
	<var: #cogMethod type: #'CogMethod *'>
	freedPIC := false.
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[cogMethod cmType = CMMethod ifTrue:
			[(objectMemory isForwarded: cogMethod methodObject) ifTrue:
				[cogMethod methodObject: (objectMemory followForwarded: cogMethod methodObject).
				 (cogMethod cmRefersToYoung not
				  and: [objectMemory isYoungObject: cogMethod methodObject]) ifTrue:
					[methodZone addToYoungReferrers: cogMethod]]].
		 cogMethod cmType = CMClosedPIC ifTrue:
			[(self followMethodReferencesInClosedPIC: cogMethod) ifTrue:
				[freedPIC := true.
				 methodZone freeMethod: cogMethod]].
		 cogMethod := methodZone methodAfter: cogMethod].
	freedPIC ifTrue:
		[self unlinkSendsToFree.
		 methodZone pruneYoungReferrers.
		 processor flushICacheFrom: codeBase to: methodZone limitZony asInteger]