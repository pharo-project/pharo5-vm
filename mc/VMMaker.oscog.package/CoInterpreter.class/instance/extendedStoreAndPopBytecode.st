stack bytecodes
extendedStoreAndPopBytecode
	"Override to use itemporary:in:put:"
	| descriptor variableType variableIndex value |
	<inline: true>
	descriptor := self fetchByte.
	self fetchNextBytecode.
	variableType := descriptor >> 6 bitAnd: 3.
	variableIndex := descriptor bitAnd: 63.
	value := self internalStackTop.
	self internalPop: 1.
	variableType = 0 ifTrue:
		[^objectMemory storePointerImmutabilityCheck: variableIndex ofObject: self receiver withValue: value].
	variableType = 1 ifTrue:
		[^self itemporary: variableIndex in: localFP put: value].
	variableType = 3 ifTrue:
		[^self storeLiteralVariable: variableIndex withValue: value].
	self error: 'illegal store'