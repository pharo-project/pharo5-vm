primitive support
externalQuickPrimitiveResponse
	"Called under the assumption that primFunctionPtr has been preloaded"
	
	| localPrimIndex |
	self assert: self isPrimitiveFunctionPointerAnIndex.
	localPrimIndex := self cCoerceSimple: primitiveFunctionPointer to: #sqInt.
	self assert: (localPrimIndex > 255 and: [localPrimIndex < 520]).
	"Quick return inst vars"
	localPrimIndex >= 264 ifTrue:
		[self pop: 1 thenPush: (self fetchPointer: localPrimIndex - 264 ofObject: self stackTop).
		 ^true].
	"Quick return constants"
	localPrimIndex = 256 ifTrue: [^true "return self"].
	localPrimIndex = 257 ifTrue: [self pop: 1 thenPush: self trueObject. ^true].
	localPrimIndex = 258 ifTrue: [self pop: 1 thenPush: self falseObject. ^true].
	localPrimIndex = 259 ifTrue: [self pop: 1 thenPush: self nilObject. ^true].
	self pop: 1 thenPush: (self integerObjectOf: localPrimIndex - 261).
	^true