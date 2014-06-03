simulation
ioReleaseThreadState: anOSThread
	<doNotGenerate>
	"See platforms/Cross/vm/sq.h for the real definition."
	threadLocalStorage removeKey: anOSThread ifAbsent: []