compaction
noTargetsFreeInClosedPIC: cPIC
	"Answer if all targets in the PIC are in-use methods."
	<var: #cPIC type: #'CogMethod *'>
	| pc entryPoint targetMethod |
	<var: #targetMethod type: #'CogMethod *'>

	1 to: cPIC cPICNumCases do:
		[:i|
		pc := self addressOfEndOfCase: i inCPIC: cPIC.
		entryPoint := backEnd jumpLongTargetBeforeFollowingAddress: pc.
		"Find target from jump.  Ignore jumps to the interpret and MNU calls within this PIC"
		(cPIC containsAddress: entryPoint) ifFalse:
			[targetMethod := self cCoerceSimple: entryPoint - cmNoCheckEntryOffset to: #'CogMethod *'.
			 targetMethod cmType ~= CMMethod ifTrue:
				[^false]]].
	^true