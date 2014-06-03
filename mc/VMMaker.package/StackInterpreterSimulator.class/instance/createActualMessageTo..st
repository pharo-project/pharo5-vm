debugging traps
createActualMessageTo: class

	"false
		ifTrue:
			[(self stringOf: messageSelector) = 'run:with:in:' ifTrue:
				[self halt]]
		ifFalse:
			[self halt: (self stringOf: messageSelector)]."

	^super createActualMessageTo: class