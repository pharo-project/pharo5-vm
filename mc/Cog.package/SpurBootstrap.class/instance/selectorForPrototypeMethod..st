method prototypes
selectorForPrototypeMethod: protoMethod
	| protoSelector |
	protoSelector := protoMethod selector.
	^(protoSelector last: protoSelector size
						- (protoSelector indexOfSubCollection: 'PROTOTYPE')
						- 'PROTOTYPE' size
						+ 1) asSymbol