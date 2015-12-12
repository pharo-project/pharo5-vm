stack bytecodes
extendedStoreBytecode
	"Override to use itemporary:in:put:"
	| descriptor variableType variableIndex |
	<inline: true>
	descriptor := self fetchByte.
	self fetchNextBytecode.
	variableType := descriptor >> 6 bitAnd: 3.
	variableIndex := descriptor bitAnd: 63.
	variableType = 0 ifTrue:
		[^objectMemory storePointer: variableIndex ofObject: self receiver withValue: self internalStackTop].
	variableType = 1 ifTrue:
		[^self itemporary: variableIndex in: localFP put: self internalStackTop].
	variableType = 3 ifTrue:
		[^self storeLiteralVariable: variableIndex withValue: self internalStackTop].
	self error: 'illegal store'