simulation
ioExitOSThread: anOSThread
	<doNotGenerate>
	"See platforms/Cross/vm/sq.h for the real definition."
	anOSThread terminate.
	self ioReleaseOSThreadState: anOSThread