allocating
needAvailableSpace: nSlots
	"Check if we have n slots available"
	GWHeaderSize + objUsed + self getUsedGet + self aetUsedGet + nSlots > self wbTopGet ifTrue:[
		self stopBecauseOf: GErrorNoMoreSpace.
		^false
	].
	^true