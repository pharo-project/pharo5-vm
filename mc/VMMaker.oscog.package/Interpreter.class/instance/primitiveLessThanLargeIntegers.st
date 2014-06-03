arithmetic largeint primitives
primitiveLessThanLargeIntegers
	"Primitive comparison operations for large integers in 64 bit range"
	| integerRcvr integerArg |
	<export: true>
	<var: 'integerRcvr' type: 'sqLong'>
	<var: 'integerArg' type: 'sqLong'>

	integerArg := self signed64BitValueOf: (self stackValue: 0).
	integerRcvr := self signed64BitValueOf: (self stackValue: 1).

	successFlag ifTrue:[
		self pop: 2.
		self pushBool: integerRcvr < integerArg
	].
