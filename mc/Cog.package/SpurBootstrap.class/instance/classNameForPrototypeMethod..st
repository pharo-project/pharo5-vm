method prototypes
classNameForPrototypeMethod: protoMethod
	| protoSelector |
	protoSelector := protoMethod selector.
	#('OLDSQUEAKPROTOTYPE' 'SQUEAKPROTOTYPE' 'PHAROPROTOTYPE' 'PROTOTYPE') do:
		[:prototype| | index |
		(index := protoSelector indexOfSubCollection: prototype) ~= 0 ifTrue:
			[^(protoSelector first: index - 1) asSymbol]].
	self error: 'really??'