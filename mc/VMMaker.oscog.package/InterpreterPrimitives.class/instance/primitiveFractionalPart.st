arithmetic float primitives
primitiveFractionalPart
	| rcvr frac trunc |
	<var: #rcvr type: #double>
	<var: #frac type: #double>
	<var: #trunc type: #double>
	rcvr := self popFloat.
	self successful
		ifTrue: [frac := self cCode: [self mod: rcvr f: (self addressOf: trunc)]
							inSmalltalk: [rcvr fractionPart].
				self pushFloat: frac]
		ifFalse: [self unPop: 1]