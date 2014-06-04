stack bytecodes
extendedStoreBytecode
	| descriptor variableType value variableIndex association isPop |
	<inline: true>
	isPop := currentBytecode = 130.  "extendedStoreAndPopBytecode"
	descriptor := self fetchByte.
	self fetchNextBytecode.
	variableType := descriptor >> 6 bitAnd: 3.
	variableIndex := descriptor bitAnd: 63.
	variableType = 2 ifTrue:
		[^self error: 'illegal store'].
	value := self internalStackTop.
	variableType = 0 ifTrue:
		[(self isObjImmutable: receiver) ifTrue:
			[isPop ifTrue: [self internalPop: 1].
			 self undoFetchNextBytecode.
			 ^self internalCannotAssign: value to: receiver withIndex: variableIndex].
		^self storePointer: variableIndex ofObject: receiver withValue: value].
	variableType = 1 ifTrue:
		[^self storePointerUnchecked: variableIndex + TempFrameStart ofObject: localHomeContext withValue: value].
	variableType = 3 ifTrue:
		[association := self literal: variableIndex.
		 (self isObjImmutable: association) ifTrue:
			[isPop ifTrue: [self internalPop: 1].
			 self undoFetchNextBytecode.
			 ^self internalCannotAssign: value to: association withIndex: ValueIndex].
		^self storePointer: ValueIndex ofObject: association withValue: value]