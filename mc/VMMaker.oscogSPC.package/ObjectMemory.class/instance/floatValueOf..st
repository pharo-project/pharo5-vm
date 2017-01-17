interpreter access
floatValueOf: oop
	"Answer the C double precision floating point value of the argument,
	 or fail if it is not a Float, and answer 0.
	 Note: May be called by translated primitive code."

	| isFloat result |
	<returnTypeC: #double>
	<var: #result type: #double>
	isFloat := self isFloatInstance: oop.
	isFloat ifTrue:
		[self cCode: '' inSmalltalk: [result := Float new: 2].
		 self fetchFloatAt: oop + self baseHeaderSize into: result.
		 ^result].
	self primitiveFail.
	^0.0