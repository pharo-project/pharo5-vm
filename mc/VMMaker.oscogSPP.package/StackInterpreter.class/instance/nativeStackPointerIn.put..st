internal interpreter access
nativeStackPointerIn: theFP put: valueOopPointer
	"See StackInterpreter class>>initializeFrameIndices"
	<inline: false>
	<option: #LowcodeVM>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	<var: #valueOopPointer type: #'char *'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*4) put: valueOopPointer