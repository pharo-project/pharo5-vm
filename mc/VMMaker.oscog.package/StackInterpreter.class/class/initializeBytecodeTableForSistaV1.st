initialization
initializeBytecodeTableForSistaV1
	"See e.g. the cass comment for EncoderForSistaV1"
	"StackInterpreter initializeBytecodeTableForSistaV1"
	"Note: This table will be used to generate a C switch statement."

	BytecodeTable := Array new: 256.
	self table: BytecodeTable from:
	#(	"1 byte bytecodes"
		(   0  15 pushReceiverVariableBytecode)
		( 16  31 pushLiteralVariable16CasesBytecode)
		( 32  63 pushLiteralConstantBytecode)
		( 64  75 pushTemporaryVariableBytecode)
		( 76	 pushReceiverBytecode)
		( 77	 pushConstantTrueBytecode)
		( 78	 pushConstantFalseBytecode)
		( 79	 pushConstantNilBytecode)
		( 80	 pushConstantZeroBytecode)
		( 81	 pushConstantOneBytecode)
		( 82	 extPushPseudoVariable)
		( 83	 duplicateTopBytecode)
	
		( 84 87	unknownBytecode)
		( 88	returnReceiver)
		( 89	returnTrue)
		( 90	returnFalse)
		( 91	returnNil)
		( 92	returnTopFromMethod)
		( 93	returnNilFromBlock)
		( 94	returnTopFromBlock)
		( 95	extNop)

		( 96	 bytecodePrimAdd)
		( 97	 bytecodePrimSubtract)
		( 98	 bytecodePrimLessThanSistaV1) "for booleanCheatSistaV1:"
		( 99	 bytecodePrimGreaterThanSistaV1) "for booleanCheatSistaV1:"
		(100	 bytecodePrimLessOrEqualSistaV1) "for booleanCheatSistaV1:"
		(101	 bytecodePrimGreaterOrEqualSistaV1) "for booleanCheatSistaV1:"
		(102	 bytecodePrimEqualSistaV1) "for booleanCheatSistaV1:"
		(103	 bytecodePrimNotEqualSistaV1) "for booleanCheatSistaV1:"
		(104	 bytecodePrimMultiply)
		(105	 bytecodePrimDivide)
		(106	 bytecodePrimMod)
		(107	 bytecodePrimMakePoint)
		(108	 bytecodePrimBitShift)
		(109	 bytecodePrimDiv)
		(110	 bytecodePrimBitAnd)
		(111	 bytecodePrimBitOr)

		(112	 bytecodePrimAt)
		(113	 bytecodePrimAtPut)
		(114	 bytecodePrimSize)
		(115	 bytecodePrimNext)		 "i.e. a 0 arg special selector"
		(116	 bytecodePrimNextPut)		 "i.e. a 1 arg special selector"
		(117	 bytecodePrimAtEnd)
		(118	 bytecodePrimIdenticalSistaV1) "for booleanCheatSistaV1:"
		(119	 bytecodePrimClass)
		(120	 bytecodePrimSpecialSelector24) "was blockCopy:"
		(121	 bytecodePrimValue)
		(122	 bytecodePrimValueWithArg)
		(123	 bytecodePrimDo)			"i.e. a 1 arg special selector"
		(124	 bytecodePrimNew)			"i.e. a 0 arg special selector"
		(125	 bytecodePrimNewWithArg)	"i.e. a 1 arg special selector"
		(126	 bytecodePrimPointX)		"i.e. a 0 arg special selector"
		(127	 bytecodePrimPointY)		"i.e. a 0 arg special selector"

		(128 143	sendLiteralSelector0ArgsBytecode)
		(144 159	sendLiteralSelector1ArgBytecode)
		(160 175	sendLiteralSelector2ArgsBytecode)

		(176 183	shortUnconditionalJump)
		(184 191	shortConditionalJumpTrue)
		(192 199	shortConditionalJumpFalse)
	
		(200 207	storeAndPopReceiverVariableBytecode)
		(208 215	storeAndPopTemporaryVariableBytecode)
		(216		popStackBytecode)

		(217 223	unknownBytecode)

		"2 byte bytecodes"
		(224		extABytecode)
		(225		extBBytecode)

		(226		extPushReceiverVariableBytecode)
		(227		extPushLiteralVariableBytecode)
		(228		extPushLiteralBytecode)
		(229		longPushTemporaryVariableBytecode)
		(230		pushClosureTempsBytecode)
		(231		pushNewArrayBytecode)
		(232		extPushIntegerBytecode)
		(233		extPushCharacterBytecode)

		(234		extSendBytecode)
		(235		extSendSuperBytecode)

		(236		extTrapOnBehaviorsBytecode)

		(237		extUnconditionalJump)
		(238		extJumpIfTrue)
		(239		extJumpIfFalse)

		(240		extStoreAndPopReceiverVariableBytecode)
		(241		extStoreAndPopLiteralVariableBytecode)
		(242		longStoreAndPopTemporaryVariableBytecode)

		(243		extStoreReceiverVariableBytecode)
		(244		extStoreLiteralVariableBytecode)
		(245		longStoreTemporaryVariableBytecode)

		(246 247	unknownBytecode)

		"3 byte bytecodes"
		(248		callPrimitiveBytecode)
		(249		unknownBytecode) "reserved for Push Float"

		(250		extPushClosureBytecode)
		(251		pushRemoteTempLongBytecode)
		(252		storeRemoteTempLongBytecode)
		(253		storeAndPopRemoteTempLongBytecode)

		(254 255	unknownBytecode)
	)