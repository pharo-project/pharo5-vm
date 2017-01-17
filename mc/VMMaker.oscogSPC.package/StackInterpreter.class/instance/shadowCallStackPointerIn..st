internal interpreter access
shadowCallStackPointerIn: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	<option: #LowcodeVM>
	<inline: false>
	<returnTypeC: #'char*'>
	<var: #theFP type: #'char *'>
	^ stackPages pointerAtPointer: theFP + FoxReceiver - (BytesPerWord*5)