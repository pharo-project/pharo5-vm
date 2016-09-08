arithmetic integer primitives
quot: integerRcvr ient: integerArg
	"See Number>>#quo:.  Rounds results towards zero."
	<inline: true>
	^integerRcvr > 0
		ifTrue:
			[integerArg > 0
				ifTrue: [integerRcvr // integerArg]
				ifFalse: [0 - (integerRcvr // (0 - integerArg))]]
		ifFalse:
			[integerArg > 0
				ifTrue: [0 - ((0 - integerRcvr) // integerArg)]
				ifFalse: [(0 - integerRcvr) // (0 - integerArg)]]