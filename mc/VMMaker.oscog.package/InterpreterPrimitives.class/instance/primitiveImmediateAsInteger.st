arithmetic float primitives
primitiveImmediateAsInteger
	"For a Smalllnteger, answer itself.
	 For a Character, answer its code as an unsigned integer.
	 For a SmallFloat, answer the signed, but unadjusted bit pattern (so as to keep the result a SmallInteger).
	 This is a good value for an immediate's hash."
	<option: #SpurObjectMemory>
	| oop value |
	oop := self stackTop.
	(objectMemory isIntegerObject: oop) ifTrue:
		[value := objectMemory integerValueOf: oop] ifFalse:
	[(objectMemory isCharacterObject: oop) ifTrue:
		[value := objectMemory characterValueOf: oop] ifFalse:
	[(objectMemory isImmediateFloat: oop) ifTrue:
		[value := objectMemory rotatedFloatBitsOf: oop] ifFalse:
	[^self primitiveFailFor: PrimErrBadReceiver]]].
	self pop: argumentCount + 1 thenPushInteger: value