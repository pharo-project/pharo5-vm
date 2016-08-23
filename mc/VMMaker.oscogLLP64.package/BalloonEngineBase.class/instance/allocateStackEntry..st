allocating
allocateStackEntry: nSlots
	"AET and Stack allocation are symmetric"
	^self needAvailableSpace: nSlots