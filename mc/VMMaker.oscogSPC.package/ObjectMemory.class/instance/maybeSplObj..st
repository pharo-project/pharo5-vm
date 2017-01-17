interpreter access
maybeSplObj: index
	<api>
	"Answer one of the objects in the SpecialObjectsArray, if in range, otherwise answer nil."
	^index < (self lengthOf: specialObjectsOop) ifTrue:
		[self fetchPointer: index ofObject: specialObjectsOop]