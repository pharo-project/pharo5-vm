object memory support
postGCAction: gcModeArg
	"Attempt to shrink free memory, signal the gc semaphore and let the Cogit do its post GC thang"
	<inline: false>
	self assert: gcModeArg = gcMode.
	super postGCAction: gcModeArg.
	cogit cogitPostGCAction: gcModeArg.
	self nilUncoggableMethods.
	gcMode := 0