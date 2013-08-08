primitive support
internalQuickPrimitiveResponse
	"Called under the assumption that primFunctionPtr has been preloaded"
	
	| localPrimIndex |
	self assert: self isPrimitiveFunctionPointerAnIndex.
	localPrimIndex := self cCoerceSimple: primitiveFunctionPointer to: #sqInt.
	self assert: (localPrimIndex > 255 and: [localPrimIndex < 520]).
	"Quick return inst vars"
	localPrimIndex >= 264 ifTrue:
		[self internalStackTopPut: (self fetchPointer: localPrimIndex - 264 ofObject: self internalStackTop).
		 ^true].
	"Quick return constants"
	localPrimIndex = 256 ifTrue: [^true "return self"].
	localPrimIndex = 257 ifTrue: [self internalStackTopPut: self trueObject. ^true].
	localPrimIndex = 258 ifTrue: [self internalStackTopPut: self falseObject. ^true].
	localPrimIndex = 259 ifTrue: [self internalStackTopPut: self nilObject. ^true].
	self internalStackTopPut: (self integerObjectOf: localPrimIndex - 261).
	^true