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
		entryPoint := literalsManager cPICCase: i jumpTargetBefore: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: targetMethod cmType = CMMethod.
			 literalsManager
				cPICCase: i
				relocateJumpLongBefore: pc
				by: (delta - targetMethod objectHeader) negated].
		pc := pc + cPICCaseSize].
	self assert: cPIC cPICNumCases > 0.
	pc := pc - cPICCaseSize.
	"Finally relocate the load of the PIC and the jump to the overflow routine ceCPICMiss:receiver:"
	backEnd relocateMethodReferenceBeforeAddress: pc + backEnd loadPICLiteralByteSize by: delta.
	backEnd relocateJumpLongBeforeFollowingAddress: pc + cPICEndSize by: delta negated