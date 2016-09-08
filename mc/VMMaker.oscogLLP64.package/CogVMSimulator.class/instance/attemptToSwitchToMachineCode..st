jump bytecodes
attemptToSwitchToMachineCode: bcpc
	"method = 16r96A294 ifTrue: [self halt]."
	^super attemptToSwitchToMachineCode: bcpc