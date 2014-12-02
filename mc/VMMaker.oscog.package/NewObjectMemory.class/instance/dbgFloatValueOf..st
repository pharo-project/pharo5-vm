interpreter access
dbgFloatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or if it is not, answer 0."

	| isFloat result |
	<returnTypeC: #double>
	<var: #result type: #double>
	isFloat := self isFloatInstance: oop.
	isFloat ifTrue:
		[self cCode: '' inSmalltalk: [result := Float new: 2].
		 self fetchFloatAt: oop + self baseHeaderSize into: result.
		 ^result].
	^0.0