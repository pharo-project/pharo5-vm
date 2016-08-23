process primitives
primitiveProcessBoundThreadId
	"Answer the receiver's current thread Id or nil, where the receiver is a Process."
	| aProcess id |
	<export: true>
	self cCode: [] inSmalltalk: [cogThreadManager isNil ifTrue: [^self primitiveFail]].
	aProcess := self stackTop.
	id := self ownerIndexOfProcess: aProcess.
	self pop: argumentCount + 1
		thenPush: (id = 0
						ifTrue: [objectMemory nilObject]
						ifFalse: [objectMemory integerObjectOf: id])