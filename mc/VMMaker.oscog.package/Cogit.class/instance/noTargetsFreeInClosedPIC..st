compaction
noTargetsFreeInClosedPIC: cPIC
	"Answerr if all targets in the PIC are in-use methods."
	<var: #cPIC type: #'CogMethod *'>
	| pc entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>
	pc := cPIC asInteger + firstCPICCaseOffset.
	1 to: cPIC cPICNumCases do:
		[:i|
		entryPoint := literalsManager cPICCase: i jumpTargetBefore: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 targetMethod cmType ~= CMMethod ifTrue:
				[^false]].
		i < cPIC cPICNumCases ifTrue:
			[pc := pc + cPICCaseSize]].
	^true