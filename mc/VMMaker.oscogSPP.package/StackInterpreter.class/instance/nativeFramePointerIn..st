internal interpreter access
nativeFramePointerIn: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*3)