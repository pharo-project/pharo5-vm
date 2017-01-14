frame access
convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc
	"bytecodeSetSelector ~= 0 ifTrue: [self halt]".
	^super convertToMachineCodeFrame: cogHomeMethod bcpc: bcpc