control & support primitives
primAsLargeInteger: anInteger
	"Converts a SmallInteger into a - non normalized! - LargeInteger;          
	 aLargeInteger will be returned unchanged."
	"Do not check for forced fail, because we need this conversion to test the 
	plugin in ST during forced fail, too."
	self debugCode: [self msg: 'primAsLargeInteger: anInteger'].
	self
		primitive: 'primAsLargeInteger'
		parameters: #(Integer )
		receiver: #Oop.
	(interpreterProxy isIntegerObject: anInteger)
		ifTrue: [^ self createLargeFromSmallInteger: anInteger]
		ifFalse: [^ anInteger]