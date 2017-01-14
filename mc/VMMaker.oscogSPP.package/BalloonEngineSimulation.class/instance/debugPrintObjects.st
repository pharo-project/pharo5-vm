debug support
debugPrintObjects
	| object end |
	<inline: false>
	object := 0.
	end := objUsed.
	[object < end] whileTrue:[
		Transcript cr; 
			nextPut:$#; print: object; space;
			print: (self objectHeaderOf: object); space.
		(self isEdge: object) 
			ifTrue:[Transcript nextPutAll:'(edge) '].
		(self isFill:object)
			ifTrue:[Transcript nextPutAll:'(fill) '].
		Transcript print: (self objectLengthOf: object); space.
		Transcript endEntry.
		object := object + (self objectLengthOf: object).
	].