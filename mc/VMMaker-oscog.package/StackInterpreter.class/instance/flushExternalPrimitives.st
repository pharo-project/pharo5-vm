plugin primitive support
flushExternalPrimitives
	"Flush the references to external functions from plugin 
	primitives. This will force a reload of those primitives when 
	accessed next. 
	Note: We must flush the method cache here so that any 
	failed primitives are looked up again."
	| oop primIdx |
	oop := objectMemory firstObject.
	[self oop: oop isLessThan: objectMemory freeStart]
		whileTrue: [(objectMemory isFreeObject: oop)
				ifFalse: [(objectMemory isCompiledMethod: oop)
						ifTrue: ["This is a compiled method"
							primIdx := self primitiveIndexOf: oop.
							primIdx = PrimitiveExternalCallIndex
								ifTrue: ["It's primitiveExternalCall"
									self flushExternalPrimitiveOf: oop]]].
			oop := objectMemory objectAfter: oop].
	self flushMethodCache.
	self flushAtCache.
	self flushExternalPrimitiveTable