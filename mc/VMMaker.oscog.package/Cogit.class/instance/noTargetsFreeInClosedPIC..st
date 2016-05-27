compaction
noTargetsFreeInClosedPIC: cPIC
	"Answer if all targets in the PIC are in-use methods."
	<var: #cPIC type: #'CogMethod *'>
	^(self cPICHasFreedTargets: cPIC) not