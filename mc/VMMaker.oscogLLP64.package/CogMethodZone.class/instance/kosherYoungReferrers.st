young referers
kosherYoungReferrers
	"Answer that all entries in youngReferrers are in-use and have the cmRefersToYoung flag set.
	 Used to check that the youngreferrers pruning routines work correctly."
	| pointer cogMethod |
	<var: #pointer type: #usqInt>
	<var: #cogMethod type: #'CogMethod *'>
	(youngReferrers > limitAddress
	 or: [youngReferrers < mzFreeStart]) ifTrue:
		[^false].
	pointer := youngReferrers.
	[pointer < limitAddress] whileTrue:
		[cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: pointer) to: #'CogMethod *'.
		 (cogMethod cmType ~= CMFree and: [cogMethod cmRefersToYoung]) ifFalse:
			[^false].
		 pointer := pointer + objectMemory wordSize].
	^true