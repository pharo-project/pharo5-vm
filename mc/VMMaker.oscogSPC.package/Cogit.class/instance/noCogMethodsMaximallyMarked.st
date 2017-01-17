compaction
noCogMethodsMaximallyMarked
	"Check that no method is maximally marked.  A maximal mark is an indication the
	 method has been scanned to increase the usage count of its referent methods."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := self cCoerceSimple: methodZoneBase to: #'CogMethod *'.
	[cogMethod < methodZone limitZony] whileTrue:
		[(cogMethod cmType ~= CMFree
		  and: [cogMethod cmUsageCount = CMMaxUsageCount]) ifTrue:
			[^false].
		 cogMethod := methodZone methodAfter: cogMethod].
	^true