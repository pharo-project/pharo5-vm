method prototypes
selectorForPrototypeMethod: protoMethod
	| protoSelector |
	protoSelector := protoMethod selector.
	protoSelector := protoSelector last: protoSelector size
						- (protoSelector indexOfSubCollection: 'PROTOTYPE')
						- 'PROTOTYPE' size
						+ 1.
	(protoSelector beginsWith: 'Dollar') ifTrue:
		[protoSelector := (Dictionary newFromPairs: #('DollarEquals:' #=))
							at: protoSelector].
	^protoSelector asSymbol