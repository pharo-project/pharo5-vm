internal interpreter access
shadowCallStackPointerIn: theFP put: valueOopPointer
	"See StackInterpreter class>>initializeFrameIndices"
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	<var: #valueOopPointer type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue:
			[stackPages pointerAtPointer: theFP + FoxMFReceiver - (BytesPerWord*5) put: valueOopPointer]
		ifFalse:
			[stackPages pointerAtPointer: theFP + FoxIFReceiver - (BytesPerWord*5) put: valueOopPointer]