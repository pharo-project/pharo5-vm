internal interpreter access
nativePreviousStackPointerIn: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*2)