compile abstract instructions
genConvertBitsToSmallFloatIn: reg scratch: scratch
	"Convert the in-SmallFloat64-range floating point value in integer register into a tagged SmallFloat64 oop.
	 c.f. Spur64BitMemoryManager>>smallFloatObjectOf:"
	| jumpZero |
	<var: #jumpZero type: #'AbstractInstruction *'>
	cogit
		RotateLeftCq: 1 R: reg;
		CmpCq: 1 R: reg.
	jumpZero :=
	cogit JumpBelowOrEqual: 0.
	cogit
		SubCq: objectMemory smallFloatExponentOffset << (objectMemory smallFloatMantissaBits + 1) R: reg.
	jumpZero jmpTarget:
	(cogit LogicalShiftLeftCq: objectMemory numTagBits R: reg).
	cogit AddCq: objectMemory smallFloatTag R: reg.
	^0