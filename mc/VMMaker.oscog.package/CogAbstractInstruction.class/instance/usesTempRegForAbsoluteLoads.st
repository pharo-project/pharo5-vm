testing
usesTempRegForAbsoluteLoads
	"Answer if TempReg is used in absolute memory loads (as it is on x64).  By default answer false, allowing subclasses to override."
	<inline: true>
	^false