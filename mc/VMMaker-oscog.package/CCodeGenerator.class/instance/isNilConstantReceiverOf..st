utilities
isNilConstantReceiverOf: sendNode
	"Answer true if the receiver of the given message send is the constant nil. Used to suppress conditional code when the condition is a translation-time constant."

	generateDeadCode ifTrue: [^false].
	^sendNode receiver isConstant and: [sendNode receiver value isNil]