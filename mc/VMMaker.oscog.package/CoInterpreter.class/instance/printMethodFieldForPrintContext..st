debug printing
printMethodFieldForPrintContext: aContext
	<inline: true>
	| meth |
	meth := objectMemory fetchPointer: MethodIndex ofObject: aContext.
	(self isMarriedOrWidowedContext: aContext)
		ifFalse:
			[self shortPrintOop: meth.
			(self methodHasCogMethod: meth) ifTrue:
				[self space; printHexnp: (self cogMethodOf: meth)]]
		ifTrue:
			[(self methodHasCogMethod: meth) ifTrue:
				[self printHexnp: (self cogMethodOf: meth); space].
			 self shortPrintOop: meth]