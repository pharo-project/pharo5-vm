compaction
relocateCallsInClosedPIC: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| delta pc entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	delta := cPIC objectHeader.
	self assert: (backEnd callTargetFromReturnAddress: cPIC asInteger + missOffset)
					= (self picAbortTrampolineFor: cPIC cmNumArgs).
	backEnd relocateCallBeforeReturnPC: cPIC asInteger + missOffset by: delta negated.

	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		pc := self addressOfEndOfCase: i inCPIC: cPIC.
		entryPoint := i = 1
						ifTrue: [backEnd jumpLongTargetBeforeFollowingAddress: pc]
						ifFalse: [backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc].
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: targetMethod cmType = CMMethod.
			 i = 1 ifTrue:
				[backEnd
					relocateJumpLongBeforeFollowingAddress: pc
					by: (delta - targetMethod objectHeader) negated]
				ifFalse:
				[backEnd
					relocateJumpLongConditionalBeforeFollowingAddress: pc
					by: (delta - targetMethod objectHeader) negated]]].
	self assert: cPIC cPICNumCases > 0.

	"Finally relocate the load of the PIC and the jump to the overflow routine ceCPICMiss:receiver:"
	backEnd relocateMethodReferenceBeforeAddress: (self addressOfEndOfCase: 2 inCPIC: cPIC)+ backEnd loadPICLiteralByteSize by: delta.
	backEnd relocateJumpLongBeforeFollowingAddress: cPIC asInteger + cPICEndOfCodeOffset by: delta negated