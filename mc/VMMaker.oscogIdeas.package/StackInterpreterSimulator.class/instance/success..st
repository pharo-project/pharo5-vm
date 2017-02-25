debugging traps
success: successBoolean
	"successBoolean ifFalse:
		[self halt]."
	^super success: successBoolean