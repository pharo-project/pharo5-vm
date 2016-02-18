compaction
noTargetsFreeInClosedPIC: cPIC
	"Answer if all targets in the PIC are in-use methods."
	^(self cPICHasFreedTargets: cPIC) not