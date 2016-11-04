accessing
numTrampolines
	^super numTrampolines + 4 + (LowcodeVM ifTrue: [ 3 ] ifFalse: [ 0 ])