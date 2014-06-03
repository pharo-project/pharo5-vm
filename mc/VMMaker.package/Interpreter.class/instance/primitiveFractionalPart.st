arithmetic float primitives
primitiveFractionalPart
	| rcvr frac trunc |
	<var: #rcvr type: 'double '>
	<var: #frac type: 'double '>
	<var: #trunc type: 'double '>
	rcvr := self popFloat.
	successFlag
		ifTrue: [self cCode: 'frac = modf(rcvr, &trunc)' inSmalltalk: [frac := rcvr fractionPart].
				self pushFloat: frac]
		ifFalse: [self unPop: 1]