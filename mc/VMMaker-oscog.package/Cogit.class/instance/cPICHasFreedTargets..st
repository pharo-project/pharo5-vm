in-line cacheing
cPICHasFreedTargets: cPIC
	<var: #cPIC type: #'CogMethod *'>
	| pc entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(entryPoint < cPIC asInteger
		 or: [entryPoint > (cPIC asInteger + cPIC blockSize)]) ifTrue:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 self assert: (targetMethod cmType = CMMethod or: [targetMethod cmType = CMFree]).
			 targetMethod cmType = CMFree ifTrue:
				[^true]].
		pc := pc + cPICCaseSize].
	^false