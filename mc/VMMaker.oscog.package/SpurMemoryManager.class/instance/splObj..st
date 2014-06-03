interpreter access
splObj: index
	<api>
	<inline: true>
	"Return one of the objects in the specialObjectsArray"
	^self fetchPointer: index ofObject: specialObjectsOop