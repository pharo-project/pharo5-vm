accessing
numTrampolines
	^ super numTrampolines + (LowcodeVM ifTrue: [4] ifFalse: [0])