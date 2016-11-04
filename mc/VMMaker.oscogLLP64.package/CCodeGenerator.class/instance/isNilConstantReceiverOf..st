utilities
isNilConstantReceiverOf: sendNode
	"Answer true if the receiver of the given message send is the constant nil. Used to suppress conditional code when the condition is a translation-time constant."

	| val |
	generateDeadCode ifTrue: [^false].
	^(self isConstantNode: sendNode receiver valueInto: [:v| val := v])
	  and: [val isNil]