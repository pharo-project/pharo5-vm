debugging traps
createActualMessageTo: class
	objectMemory bootstrapping ifTrue:
		[self halt].
	"false
		ifTrue:
			[(self stringOf: messageSelector) = 'run:with:in:' ifTrue:
				[self halt]]
		ifFalse:
			[self halt: (self stringOf: messageSelector)]."

	^super createActualMessageTo: class