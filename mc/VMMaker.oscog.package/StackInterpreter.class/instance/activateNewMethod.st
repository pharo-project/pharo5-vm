message sending
activateNewMethod
	| methodHeader |
	methodHeader := self justActivateNewMethod.

	"Now check for stack overflow or an event (interrupt, must scavenge, etc)."
	stackPointer < stackLimit ifTrue:
		[self handleStackOverflowOrEventAllowContextSwitch: (self canContextSwitchIfActivating: newMethod header: methodHeader)]