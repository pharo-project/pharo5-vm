arithmetic integer primitives
primitiveQuo
	"Rounds negative results towards zero."
	| integerRcvr integerArg integerResult |
	integerRcvr := self stackIntegerValue: 1.
	integerArg := self stackIntegerValue: 0.
	self success: integerArg ~= 0.
	self successful ifTrue:
		[integerResult := self quot: integerRcvr ient: integerArg].
	self pop2AndPushIntegerIfOK: integerResult