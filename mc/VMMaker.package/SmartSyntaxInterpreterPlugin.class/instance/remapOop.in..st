simulation
remapOop: oopOrList in: aBlock
	<doNotGenerate>
	| ctxt tempNames tempIndices |
	ctxt := thisContext sender.
	tempNames := ctxt tempNames.
	oopOrList isArray
		ifTrue:
			[tempIndices := oopOrList collect: [:tempName| tempNames indexOf: tempName].
			 tempIndices do:
				[:index| interpreterProxy pushRemappableOop: (ctxt namedTempAt: index)]]
		ifFalse: [interpreterProxy pushRemappableOop: oopOrList].
	^aBlock ensure:
		[oopOrList isArray
			ifTrue:
				[tempIndices reverseDo:
					[:index| ctxt namedTempAt: index put: interpreterProxy popRemappableOop]]
			ifFalse:
				[1 to: ctxt numTemps do:
					[:index|
					(ctxt tempAt: index) = oopOrList ifTrue:
						[ctxt tempAt: index put: interpreterProxy topRemappableOop]].
				 interpreterProxy popRemappableOop]]