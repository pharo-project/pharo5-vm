compaction
noTargetsFreeInClosedPIC: cPIC
	"Answerr if all targets in the PIC are in-use methods."
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
			 targetMethod cmType ~= CMMethod ifTrue:
				[^false]].
		i < cPIC cPICNumCases ifTrue:
			[pc := pc + cPICCaseSize]].
	^true