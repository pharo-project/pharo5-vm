printing
printOn: aStream
	"A hook to allow subclasses to print their state if useful."
	<doNotGenerate>
	super printOn: aStream.
	self printStateOn: aStream