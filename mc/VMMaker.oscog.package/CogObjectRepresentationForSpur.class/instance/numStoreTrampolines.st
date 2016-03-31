initialization
numStoreTrampolines
	"Number of trampolines for instance variable store. Trampolines from 0 to 
	numStoreTrampoline - 1 are dedicated to an inst var index, the last one is generic.
	
	WARNING: Check the C declaration of ceStoreTrampolines if this number is increased."
	^ 3