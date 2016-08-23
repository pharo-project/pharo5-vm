accessing
splObj: index
	<api>
	<inline: true>
	"Return one of the objects in the SpecialObjectsArray"
	^self fetchPointer: index ofObject: specialObjectsOop