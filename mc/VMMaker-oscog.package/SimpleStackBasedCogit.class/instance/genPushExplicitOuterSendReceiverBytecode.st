bytecode generators
genPushExplicitOuterSendReceiverBytecode
	"Uncached push explicit outer send receiver"
	| levelOop |
	levelOop := self getLiteral: byte1.
	self assert: (objectMemory isIntegerObject: levelOop).
	^self genPushExplicitOuterSendReceiver: (objectMemory integerValueOf: levelOop)