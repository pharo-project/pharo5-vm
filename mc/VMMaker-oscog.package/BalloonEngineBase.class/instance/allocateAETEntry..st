allocating
allocateAETEntry: nSlots
	"Allocate n slots in the active edge table"
	^self needAvailableSpace: nSlots