internal interpreter access
nativeFramePointerIn: theFP put: valueOopPointer
	"See StackInterpreter class>>initializeFrameIndices"
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	<var: #valueOopPointer type: #'char*'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*3) put: valueOopPointer