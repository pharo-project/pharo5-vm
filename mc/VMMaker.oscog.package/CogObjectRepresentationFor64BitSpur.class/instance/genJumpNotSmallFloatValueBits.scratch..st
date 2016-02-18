compile abstract instructions
genJumpNotSmallFloatValueBits: reg scratch: exponent
	"Generate a test to check that the integer register contains a floating point value within the SmallFloat64 range,
	 and answer the jump.  c.f. Spur64BitMemoryManager>>isSmallFloatValue:"
	| jumpFail jumpTest jumpMinExponent jumpMaxExponent jumpZeroMantissa |
	<var: #jumpFail type: #'AbstractInstruction *'>
	<var: #jumpTest type: #'AbstractInstruction *'>
	<var: #jumpMinExponent type: #'AbstractInstruction *'>
	<var: #jumpMaxExponent type: #'AbstractInstruction *'>
	<var: #jumpZeroMantissa type: #'AbstractInstruction *'>
	self flag: 'if we combine the exponent range test with the conversion to tagged representation we test for a zero exponent only once. further, if we extract tags once into a scratch on the input side we test for immediates, SmallInteger and SmallFloat using the same intermediate result.  so to do is to move fp arithmetic into the object representations'.
	cogit MoveR: reg R: exponent.
	true
		ifTrue: [cogit
				LogicalShiftLeftCq: 1 R: exponent; "drop sign"
				LogicalShiftRightCq: objectMemory smallFloatMantissaBits + 1 R: exponent] "shift exponent down"
		ifFalse: [cogit
				LogicalShiftRightCq: objectMemory smallFloatMantissaBits R: exponent;
				AndCq: 16r7FF R: exponent].  "ieee double precision mantissa is 11 bits"
	cogit CmpCq: objectMemory smallFloatExponentOffset R: exponent.
	jumpMinExponent := cogit JumpLessOrEqual: 0.
	cogit CmpCq: 255 + objectMemory smallFloatExponentOffset R: exponent. "SmallFloat exponent is 8 bits"
	jumpMaxExponent := cogit JumpLessOrEqual: 0.
	jumpFail :=
	cogit Jump: 0.
	jumpMinExponent jmpTarget:
	(cogit TstCq: 1 << objectMemory smallFloatMantissaBits - 1 R: reg). "test mantissa bits"
	jumpZeroMantissa := cogit JumpZero: 0.
	cogit CmpCq: objectMemory smallFloatExponentOffset R: exponent.
	jumpTest :=
	cogit Jump: 0.
	jumpZeroMantissa jmpTarget:
	(cogit CmpCq: 0 R: exponent).
	jumpTest jmpTarget:
	(cogit JumpNonZero: jumpFail).
	jumpMaxExponent jmpTarget: cogit Label.
	^jumpFail