translation support
addressOf: anObject put: aBlock
	<doNotGenerate>
	"Simulate a C pointer.  Translates into &anObject in C. Provides something
	 that evaluates aBlock with the new value in response to at:put:"
	| thing |
	thing := anObject.
	^CPluggableAccessor new
		setObject: nil;
		atBlock: [:obj :idx| thing]
		atPutBlock: [:obj :idx :val| aBlock value: (thing := val)]