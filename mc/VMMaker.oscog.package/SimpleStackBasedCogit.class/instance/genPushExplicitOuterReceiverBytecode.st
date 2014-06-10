bytecode generators
genPushExplicitOuterReceiverBytecode
	"Uncached push explicit outer send receiver"
	| levelOop |
	levelOop := self getLiteral: byte1.
	self assert: (objectMemory isIntegerObject: levelOop).
	^self genPushExplicitOuterReceiver: (objectMemory integerValueOf: levelOop)