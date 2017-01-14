internal interpreter access
nativeStackPointerIn: theFP put: valueOopPointer
	"See StackInterpreter class>>initializeFrameIndices"
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	<var: #valueOopPointer type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue:
			[stackPages pointerAtPointer: theFP + FoxMFReceiver - (BytesPerWord*4) put: valueOopPointer]
		ifFalse:
			[stackPages pointerAtPointer: theFP + FoxIFReceiver - (BytesPerWord*4) put: valueOopPointer]