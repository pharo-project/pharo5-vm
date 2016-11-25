initialization
initializeBytecodeTableForNewspeakV4
	"StackInterpreter initializeBytecodeTableForNewspeakV4"
	"Note: This table will be used to generate a C switch statement."

	initializationOptions at: #NewsqueakV4BytecodeSet put: (NewsqueakV4BytecodeSet := true).
	BytecodeTable := Array new: 256.
	BytecodeEncoderClassName := #EncoderForNewsqueakV4.
	BytecodeSetHasExtensions := true.
	LongStoreBytecode := 234.
	self table: BytecodeTable from:
	#(	"1 byte bytecodes"
		(   0  15 pushReceiverVariableBytecode)
		( 16  31 pushLiteralVariable16CasesBytecode)
		( 32  63 pushLiteralConstantBytecode)
		( 64  75 pushTemporaryVariableBytecode)
		( 76	 pushReceiverBytecode)
		( 77	 extPushPseudoVariableOrOuterBytecode)
		( 78	 pushConstantZeroBytecode)
		( 79	 pushConstantOneBytecode)

		( 80	 bytecodePrimAdd)
		( 81	 bytecodePrimSubtract)
		( 82	 bytecodePrimLessThanV4) "for booleanCheatV4:"
		( 83	 bytecodePrimGreaterThanV4) "for booleanCheatV4:"
		( 84	 bytecodePrimLessOrEqualV4) "for booleanCheatV4:"
		( 85	 bytecodePrimGreaterOrEqualV4) "for booleanCheatV4:"
		( 86	 bytecodePrimEqualV4) "for booleanCheatV4:"
		( 87	 bytecodePrimNotEqualV4) "for booleanCheatV4:"
		( 88	 bytecodePrimMultiply)
		( 89	 bytecodePrimDivide)
		( 90	 bytecodePrimMod)
		( 91	 bytecodePrimMakePoint)
		( 92	 bytecodePrimBitShift)
		( 93	 bytecodePrimDiv)
		( 94	 bytecodePrimBitAnd)
		( 95	 bytecodePrimBitOr)

		( 96	 bytecodePrimAt)
		( 97	 bytecodePrimAtPut)
		( 98	 bytecodePrimSize)
		( 99	 bytecodePrimNext)
		(100	 bytecodePrimNextPut)
		(101	 bytecodePrimAtEnd)
		(102	 bytecodePrimIdenticalV4) "for booleanCheatV4:"
		(103	 bytecodePrimClass)
		(104	 bytecodePrimNotIdenticalV4) "was blockCopy:"
		(105	 bytecodePrimValue)
		(106	 bytecodePrimValueWithArg)
		(107	 bytecodePrimDo)
		(108	 bytecodePrimNew)
		(109	 bytecodePrimNewWithArg)
		(110	 bytecodePrimPointX)
		(111	 bytecodePrimPointY)

		(112 127	sendLiteralSelector0ArgsBytecode)
		(128 143	sendLiteralSelector1ArgBytecode)
		(144 159	sendLiteralSelector2ArgsBytecode)
		(160 175	sendAbsentImplicit0ArgsBytecode)

		(176 183	storeAndPopReceiverVariableBytecode)
		(184 191	storeAndPopTemporaryVariableBytecode)

		(192 199	shortUnconditionalJump)
		(200 207	shortConditionalJumpTrue)
		(208 215	shortConditionalJumpFalse)

		(216		returnReceiver)
		(217		returnTopFromMethod)
		(218		extReturnTopFromBlock)

		(219		duplicateTopBytecode)
		(220		popStackBytecode)
		(221		extNopBytecode)
		(222 223	unknownBytecode)

		"2 byte bytecodes"
		(224		extABytecode)
		(225		extBBytecode)

		(226		extPushReceiverVariableBytecode)
		(227		extPushLiteralVariableBytecode)
		(228		extPushLiteralBytecode)
		(229		extPushIntegerBytecode)
		(230		longPushTemporaryVariableBytecode)
		(231		pushNewArrayBytecode)
		(232		extStoreReceiverVariableBytecode)
		(233		extStoreLiteralVariableBytecode)
		(234		longStoreTemporaryVariableBytecode)
		(235		extStoreAndPopReceiverVariableBytecode)
		(236		extStoreAndPopLiteralVariableBytecode)
		(237		longStoreAndPopTemporaryVariableBytecode)

		(238		extSendBytecode)
		(239		extSendSuperBytecode)
		(240		extSendAbsentImplicitBytecode)
		(241		extSendAbsentDynamicSuperBytecode)

		(242		extUnconditionalJump)
		(243		extJumpIfTrue)
		(244		extJumpIfFalse)

		(245		extSendAbsentSelfBytecode)

		(246 248	unknownBytecode)

		"3 byte bytecodes"
		(249		callPrimitiveBytecode)

		(250		pushRemoteTempLongBytecode)
		(251		storeRemoteTempLongBytecode)
		(252		storeAndPopRemoteTempLongBytecode)
		(253		extPushClosureBytecode)
		(254		extSendAbsentOuterBytecode)

		(255		unknownBytecode)
	)