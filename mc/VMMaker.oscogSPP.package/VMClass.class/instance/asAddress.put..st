translation support
asAddress: address put: aBlock
	<doNotGenerate>
	"Simulate a C pointer.  Translates into address in C. Provides something
	 that evaluates aBlock with the new value in response to at:put:"
	^CPluggableAccessor new
		setObject: nil;
		atBlock: [:obj :idx| self error: 'cannot dereference pseudo-pointers']
		atPutBlock: [:obj :idx :val| aBlock value: val]