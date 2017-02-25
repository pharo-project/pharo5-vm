simulation
remapOop: oopOrList in: aBlock
	"Call remapOop: for the variable oopOrList (or all of the variables in oopOrList) before evaluating
	 aBlock, and restore them after.  If this is Spur, do nothing, since Spur does not GC on allocation
	 and the  SmartSyntaxPluginCodeGenerator generates null code for this op in Spur."
	<doNotGenerate>
	| ctxt tempNames tempIndices |
	interpreterProxy hasSpurMemoryManagerAPI ifTrue:
		[^aBlock value].
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