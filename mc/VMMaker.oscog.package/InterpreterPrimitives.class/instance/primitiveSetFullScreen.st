I/O primitives
primitiveSetFullScreen
	"On platforms that support it, set full-screen mode to the value of the boolean argument."

	| argOop |
	argOop := self stackTop.
	argOop = objectMemory trueObject
		ifTrue: [self ioSetFullScreen: true]
		ifFalse: [ argOop = objectMemory falseObject
				ifTrue: [self ioSetFullScreen: false]
				ifFalse: [self primitiveFail]].
	self successful ifTrue: [self pop: 1]