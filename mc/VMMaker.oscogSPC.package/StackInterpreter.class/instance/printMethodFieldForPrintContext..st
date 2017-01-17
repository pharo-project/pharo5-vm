debug printing
printMethodFieldForPrintContext: aContext
	<inline: true>
	self shortPrintOop: (objectMemory fetchPointer: MethodIndex ofObject: aContext)