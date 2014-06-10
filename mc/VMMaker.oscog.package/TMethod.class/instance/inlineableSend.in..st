inlining
inlineableSend: aNode in: aCodeGen
	"Answer true if the given send node is a call to a method that can be inlined."

	| m |
	self maybeBreakFor: aNode in: aCodeGen.
	aNode isSend ifFalse: [ ^false ].
	m := aCodeGen methodNamed: aNode selector.  "nil if builtin or external function"
	^m ~= nil and: [m ~~ self and: [m isComplete and: [aCodeGen mayInline: m selector]]]