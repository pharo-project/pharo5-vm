in-line cacheing
cPICCompactAndIsNowEmpty: cPIC
	"Scan the CPIC for target methods that have been freed and eliminate them.
	 Since the first entry cannot be eliminated, answer that the PIC should be
	 freed if the first entry is to a free target.  Answer if the PIC is now empty or should be freed."
	<var: #cPIC type: #'CogMethod *'>
	| pc entryPoint targetMethod targets tags methods used |
	<var: #targetMethod	type: #'CogMethod *'>
	<var: #tags			declareC: 'int tags[MaxCPICCases]'>
	<var: #targets			declareC: 'sqInt targets[MaxCPICCases]'>
	<var: #methods		declareC: 'sqInt methods[MaxCPICCases]'>
	self cCode: [] inSmalltalk:
		[tags := CArrayAccessor on: (Array new: MaxCPICCases).
		 targets := CArrayAccessor on: (Array new: MaxCPICCases).
		 methods := CArrayAccessor on: (Array new: MaxCPICCases)].
	used := 0.
	1 to: cPIC cPICNumCases do:
		[:i| | valid |
		 pc := self addressOfEndOfCase: i inCPIC: cPIC.
		 entryPoint := i = 1
						ifTrue: [backEnd jumpLongTargetBeforeFollowingAddress: pc]
						ifFalse: [backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc].
		 valid := true.
		 "Collect all target triples except for triples whose entry-point is a freed method"
		 (cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: (targetMethod cmType = CMMethod or: [targetMethod cmType = CMFree]).
			 targetMethod cmType = CMFree ifTrue:
				[i = 1 ifTrue: [^true]. "cannot filter out the first entry cuz classTag is at pont of send."
				 valid := false]].
		 valid ifTrue:
			[tags at: used put: (i > 1 ifTrue: [backEnd literal32BeforeFollowingAddress: pc - backEnd jumpLongConditionalByteSize]).
			 targets at: used put: entryPoint.
			 methods at: used put: (backEnd literalBeforeFollowingAddress: pc - (i = 1
																				ifTrue: [backEnd jumpLongByteSize]
																				ifFalse: [backEnd jumpLongConditionalByteSize + backEnd cmpC32RTempByteSize])).
			 used := used + 1]].
	used = cPIC cPICNumCases ifTrue:
		[^false].
	used = 0 ifTrue:
		[^true].
	cPIC cPICNumCases: used.
	used = 1 ifTrue:
		[pc := self addressOfEndOfCase: 2 inCPIC: cPIC.
		 self rewriteCPIC: cPIC caseJumpTo: pc.
		 ^false].
	"the first entry cannot change..."
	1 to: used - 1 do:
		[:i|
		 pc := self addressOfEndOfCase: i + 1 inCPIC: cPIC.
		 self rewriteCPICCaseAt: pc tag: (tags at: i) objRef: (methods at: i) target: (targets at: i)].

	"finally, rewrite the jump 3 instr  before firstCPICCaseOffset to jump to the beginning of this new case"
	self rewriteCPIC: cPIC caseJumpTo: pc - cPICCaseSize.
	^false