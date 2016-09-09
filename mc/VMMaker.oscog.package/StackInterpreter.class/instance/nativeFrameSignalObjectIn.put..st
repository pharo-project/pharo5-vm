internal interpreter access
nativeFrameSignalObjectIn: theFP put: oop
	"See StackInterpreter class>>initializeFrameIndices"
	<inline: false>
	<option: #LowcodeVM>
	<var: #theFP type: #'char *'>
	^ stackPages longAt: theFP + FoxReceiver - BytesPerWord put: oop