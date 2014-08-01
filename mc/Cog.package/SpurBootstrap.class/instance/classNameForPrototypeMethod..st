method prototypes
classNameForPrototypeMethod: protoMethod
	| protoSelector |
	protoSelector := protoMethod selector.
	#('SQUEAKPROTOTYPE' 'PHAROPROTOTYPE' 'PROTOTYPE') do:
		[:prototype| | index |
		(index := protoSelector indexOfSubCollection: 'PROTOTYPE') ~= 0 ifTrue:
			[^(protoSelector first: index - 1) asSymbol]].
	self error: 'really??'