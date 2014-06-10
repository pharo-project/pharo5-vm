utilities
dbgFloatValueOf: oop
	"This version answers the value of a float or nil if not a flat *WITHOUT* setting successFlag or any other such nonsense.  It is hence safe for use in debug printing.  Sheesh."

	| result |
	<returnTypeC: #double>
	<var: #result type: #double>
	self flag: #Dan.  "None of the float stuff has been converted for 64 bits"
	((objectMemory isNonImmediate: oop)
	and: [(objectMemory fetchClassOfNonImm: oop) = (objectMemory splObj: ClassFloat)]) ifTrue:
		[self cCode: '' inSmalltalk: [result := Float new: 2].
		 objectMemory fetchFloatAt: oop + BaseHeaderSize into: result.
		 ^result].
	^nil