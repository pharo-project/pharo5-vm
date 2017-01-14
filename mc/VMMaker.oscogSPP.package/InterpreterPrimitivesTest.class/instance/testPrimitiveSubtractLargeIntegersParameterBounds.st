testing - primitiveSubtractLargeIntegers
testPrimitiveSubtractLargeIntegersParameterBounds
	"Prior to VMMaker VMMaker 4.10.1 enhancement by Nicolas Cellier, range was
	restricted and this test would fail."

	| intOne intTwo |
	"LargeNegativeInteger at lower range boundary"
	intOne := -16r8000000000000000. "maximum negative 64 bit value"
	intTwo := -16r7FFFFFFFFFFFFFFF.
	self shouldnt: [intTwo minus64: intOne]
		raise: Error.
