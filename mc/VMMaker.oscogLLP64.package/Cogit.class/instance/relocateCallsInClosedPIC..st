compaction
relocateCallsInClosedPIC: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| refDelta callDelta pc entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	refDelta := cPIC objectHeader.
	callDelta := backEnd zoneCallsAreRelative ifTrue: [refDelta] ifFalse: [0].
	
	self assert: (backEnd callTargetFromReturnAddress: cPIC asInteger + missOffset)
					= (self picAbortTrampolineFor: cPIC cmNumArgs).
	backEnd relocateCallBeforeReturnPC: cPIC asInteger + missOffset by: callDelta negated.

	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		pc := self addressOfEndOfCase: i inCPIC: cPIC.
		entryPoint := i = 1
						ifTrue: [backEnd jumpLongTargetBeforeFollowingAddress: pc]
						ifFalse: [backEnd jumpLongConditionalTargetBeforeFollowingAddress: pc].
		(cPIC containsAddress: entryPoint) 
			ifTrue: 
			["Interpret/MNU"
			backEnd zoneCallsAreRelative ifFalse: [
				i = 1 ifTrue:
					[backEnd
						relocateJumpLongBeforeFollowingAddress: pc
						by: refDelta]
					ifFalse:
					[backEnd
						relocateJumpLongConditionalBeforeFollowingAddress: pc
						by: refDelta]]]
			ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: targetMethod cmType = CMMethod.
			 i = 1 ifTrue:
				[backEnd
					relocateJumpLongBeforeFollowingAddress: pc
					by: (callDelta - targetMethod objectHeader) negated]
				ifFalse:
				[backEnd
					relocateJumpLongConditionalBeforeFollowingAddress: pc
					by: (callDelta - targetMethod objectHeader) negated]]].
	self assert: cPIC cPICNumCases > 0.

	"Finally relocate the load of the PIC and the jump to the overflow routine ceCPICMiss:receiver:"
	backEnd relocateMethodReferenceBeforeAddress: (self addressOfEndOfCase: 2 inCPIC: cPIC)+ backEnd loadPICLiteralByteSize by: refDelta.
	backEnd relocateJumpLongBeforeFollowingAddress: cPIC asInteger + cPICEndOfCodeOffset by: callDelta negated