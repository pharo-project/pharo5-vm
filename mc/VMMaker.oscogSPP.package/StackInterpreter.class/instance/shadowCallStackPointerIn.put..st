internal interpreter access
shadowCallStackPointerIn: theFP put: valueOopPointer
	"See StackInterpreter class>>initializeFrameIndices"
	<option: #LowcodeVM>
	<inline: false>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	<var: #valueOopPointer type: #'char*'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*5) put: valueOopPointer