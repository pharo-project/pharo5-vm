debug printing
printMethodFieldForPrintContext: aContext
	<inline: true>
	| meth |
	meth := objectMemory fetchPointer: MethodIndex ofObject: aContext.
	(self methodHasCogMethod: meth) ifTrue:
		[self printHexnp: (self cogMethodOf: meth); space].
	self shortPrintOop: meth.