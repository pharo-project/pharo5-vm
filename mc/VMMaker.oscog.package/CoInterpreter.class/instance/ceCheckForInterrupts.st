trampolines
ceCheckForInterrupts
	<api>
	| switched |
	self cCode: [] inSmalltalk:
		[self maybeCheckStackDepth: 0 sp: stackPointer pc: instructionPointer].
	switched := self checkForEventsMayContextSwitch: true.
	self returnToExecutive: false postContextSwitch: switched