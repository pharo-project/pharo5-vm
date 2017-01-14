interpreter access
splObj: index put: anObject
	"Set one of the objects in the SpecialObjectsArray"
	self storePointer: index ofObject: specialObjectsOop withValue: anObject