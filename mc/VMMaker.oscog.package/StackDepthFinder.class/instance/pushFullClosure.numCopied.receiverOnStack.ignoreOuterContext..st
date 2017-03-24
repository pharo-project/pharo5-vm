instruction decoding
pushFullClosure: literal numCopied: numCopied receiverOnStack: receiverOnStack ignoreOuterContext: ignoreOuterContext
	"Push Closure bytecode."
	| delta |
	delta := 1 - (receiverOnStack ifTrue: [1] ifFalse: [0]) - numCopied.
	delta ~= 0 ifTrue: [self drop: delta negated]