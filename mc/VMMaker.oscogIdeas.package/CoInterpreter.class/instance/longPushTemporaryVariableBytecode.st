stack bytecodes
longPushTemporaryVariableBytecode
	"230		11100110	i i i i i i i i	Push Temporary Variable #iiiiiiii"
	| index |
	index := self fetchByte.
	self fetchNextBytecode.
	self internalPush: (self itemporary: index in: localFP)