plugin primitive support
flushExternalPrimitives
	"Flush the references to external functions from plugin primitives.
	 This will force a reload of those primitives when accessed next. 
	 Note: We must flush the method cache here also, so that any failed
	 primitives are looked up again."
	objectMemory allObjectsDo:
		[:oop| | primIdx |
		(objectMemory isFreeObject: oop) ifFalse:
			[(objectMemory isCompiledMethod: oop) ifTrue: "This is a compiled method"
				[primIdx := self primitiveIndexOf: oop.
				 primIdx = PrimitiveExternalCallIndex ifTrue: "It's primitiveExternalCall"
					[self flushExternalPrimitiveOf: oop]]]].
	self flushMethodCache.
	self flushAtCache.
	self flushExternalPrimitiveTable