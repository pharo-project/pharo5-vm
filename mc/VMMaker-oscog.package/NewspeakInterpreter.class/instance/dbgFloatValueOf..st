utilities
dbgFloatValueOf: oop
	"This version answers the value of a float or nil if not a flat *WITHOUT* setting successFlag or any other such nonsense.  It is hence safe for use in debug printing.  Sheesh."

	| result |
	<returnTypeC: #double>
	<var: #result type: #double>
	self flag: #Dan.  "None of the float stuff has been converted for 64 bits"
	((self isNonIntegerObject: oop)
	and: [(self fetchClassOfNonImm: oop) = (self splObj: ClassFloat)]) ifTrue:
		[self cCode: '' inSmalltalk: [result := Float new: 2].
		 self fetchFloatAt: oop + BaseHeaderSize into: result.
		 ^result].
	^nil