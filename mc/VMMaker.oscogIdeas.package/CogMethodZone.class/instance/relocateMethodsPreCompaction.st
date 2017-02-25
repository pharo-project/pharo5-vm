compaction
relocateMethodsPreCompaction
	"All surviving methods have had the amount they are going to relocate by
	 stored in their objectHeader fields.  Relocate all relative calls so that after
	 the compaction of both the method containing each call and the call target
	 the calls invoke the same target."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod asUnsignedInteger < mzFreeStart] whileTrue:
		[cogMethod cmType ~= CMFree ifTrue:
			[cogMethod cmType = CMClosedPIC
				ifTrue: [cogit relocateCallsInClosedPIC: cogMethod]
				ifFalse: [cogit relocateCallsAndSelfReferencesInMethod: cogMethod]].
		 cogMethod := self methodAfter: cogMethod].
	self relocateAndPruneYoungReferrers.
	^true