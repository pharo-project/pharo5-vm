process primitive support
checkProfileTick: aPrimitiveMethod
	"Check if the profile timer has expired and if so take a sample.
	 If the primitive has failed sample the profileMethod as nil."
	<inline: false>
	self assert: nextProfileTick ~= 0.
	self ioHighResClock >= nextProfileTick ifTrue:
		[profileProcess := self activeProcess.
		 profileMethod := self successful ifTrue: [aPrimitiveMethod] ifFalse: [objectMemory nilObject].
		 self forceInterruptCheck.
		 nextProfileTick := 0]