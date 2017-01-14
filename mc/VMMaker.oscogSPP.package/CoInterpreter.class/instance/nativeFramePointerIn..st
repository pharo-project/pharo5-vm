internal interpreter access
nativeFramePointerIn: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue:
			[stackPages pointerAtPointer: theFP + FoxMFReceiver - (BytesPerWord*3) ]
		ifFalse:
			[stackPages pointerAtPointer: theFP + FoxIFReceiver - (BytesPerWord*3) ]