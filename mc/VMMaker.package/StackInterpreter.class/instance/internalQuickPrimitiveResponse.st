primitive support
internalQuickPrimitiveResponse
	"Invoke a quick primitive.
	 Called under the assumption that primFunctionPtr has been preloaded"
	
	| localPrimIndex |
	self assert: self isPrimitiveFunctionPointerAnIndex.
	localPrimIndex := self cCoerceSimple: primitiveFunctionPointer to: #sqInt.
	self assert: (localPrimIndex > 255 and: [localPrimIndex < 520]).
	"Quick return inst vars"
	localPrimIndex >= 264 ifTrue:
		[self internalStackTopPut: (objectMemory fetchPointer: localPrimIndex - 264 ofObject: self internalStackTop).
		 ^true].
	"Quick return constants"
	localPrimIndex = 256 ifTrue: [^true "return self"].
	localPrimIndex = 257 ifTrue: [self internalStackTopPut: objectMemory trueObject. ^true].
	localPrimIndex = 258 ifTrue: [self internalStackTopPut: objectMemory falseObject. ^true].
	localPrimIndex = 259 ifTrue: [self internalStackTopPut: objectMemory nilObject. ^true].
	self internalStackTopPut: (objectMemory integerObjectOf: localPrimIndex - 261).
	^true