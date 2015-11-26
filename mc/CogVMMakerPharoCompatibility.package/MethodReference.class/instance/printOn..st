printing
printOn: aStream
	| actualClass |
	"Print the receiver on a stream"
	actualClass := classSymbol asString.
	classIsMeta ifTrue: [actualClass := actualClass, ' class'].
	super printOn: aStream.
	aStream nextPutAll: ' ', actualClass, ' >> ', methodSymbol printString.