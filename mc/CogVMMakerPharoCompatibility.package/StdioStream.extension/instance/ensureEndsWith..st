*CogVMMakerPharoCompatibility
ensureEndsWith: anObject
	"Append anObject to the receiver IFF it is non-empty and there is not one on the end."
	(self peek = anObject) ifTrue: [^self].
	self nextPut: anObject