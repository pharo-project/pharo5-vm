simulator initialization
falsifyBytecodeSetFlags: initializationOptions
	SqueakV3PlusClosuresBytecodeSet.
	NewsqueakV4BytecodeSet.
	SistaV1BytecodeSet.
	classPool keys do:
		[:k|
		(k endsWith: 'BytecodeSet') ifTrue:
			[classPool at: k put: false.
			 initializationOptions at: k put: false]]

	"classPool keys select: [:k| k endsWith: 'BytecodeSet']"