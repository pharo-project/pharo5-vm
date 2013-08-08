I/O primitives
primitiveSetFullScreen
	"On platforms that support it, set full-screen mode to the value of the boolean argument."

	| argOop |
	argOop := self stackTop.
	argOop = trueObj
		ifTrue: [self ioSetFullScreen: true]
		ifFalse: [ argOop = falseObj
				ifTrue: [self ioSetFullScreen: false]
				ifFalse: [self primitiveFail]].
	self successful ifTrue: [self pop: 1].
