debug support
checkForInterrupts
	"Prevent interrupts so that traces are consistent during detailed debugging"

	"self halt."
	true ifTrue:
		[interruptCheckCounter := 1000.
		^self].
	^ super checkForInterrupts