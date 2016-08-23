image save/restore
setImageHeaderFlagsFrom: headerFlags
	"Set the flags that are contained in the 7th long of the image header."
	imageHeaderFlags := headerFlags. "so as to preserve unrecognised flags."
	fullScreenFlag := headerFlags bitAnd: 1.
	imageFloatsBigEndian := (headerFlags bitAnd: 2) = 0 ifTrue: [1] ifFalse: [0].
	processHasThreadId := (headerFlags bitAnd: 4) ~= 0.
	flagInterpretedMethods := (headerFlags bitAnd: 8) ~= 0.
	preemptionYields := (headerFlags bitAnd: 16) = 0.
	noThreadingOfGUIThread := (headerFlags bitAnd: 32) ~= 0.
	newFinalization := (headerFlags bitAnd: 64) ~= 0.

	processHasThreadId ifFalse:
		[self print: 'warning, processHasThreadId flag is unset; cannot function as a threaded VM if so.'; cr]