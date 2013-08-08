ephemerons
markEphemeronAsReported: oop 

	"
	Set the 3rd slot of ephemeron to true. 
	Means that ephemeron are placed into the finalization list and pending to be handled by image.
	We doing this to prevent reporting same ephemeron twice, if during handling a finalization,
	a language side can allocate some extra objects which could cause triggering GC."

	self storePointerUnchecked: 2 ofObject: oop withValue: self trueObject 