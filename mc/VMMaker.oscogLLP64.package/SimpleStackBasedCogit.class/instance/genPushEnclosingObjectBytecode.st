bytecode generators
genPushEnclosingObjectBytecode
	"Uncached push enclosing object"
	| levelOop |
	levelOop := self getLiteral: byte1.
	self assert: (objectMemory isIntegerObject: levelOop).
	^self genPushEnclosingObjectAt: (objectMemory integerValueOf: levelOop)