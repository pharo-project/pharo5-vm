method prototypes
classNameForPrototypeMethod: protoMethod
	| protoSelector |
	protoSelector := protoMethod selector.
	^(protoSelector first: (protoSelector indexOfSubCollection: 'PROTOTYPE') - 1) asSymbol