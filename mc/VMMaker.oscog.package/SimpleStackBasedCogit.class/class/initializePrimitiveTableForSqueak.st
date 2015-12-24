class initialization
initializePrimitiveTableForSqueak
	"Initialize the table of primitive generators.  This does not include normal primitives implemented in the coInterpreter.
	 N.B. primitives that don't have an explicit arg count (the integer following the generator) may be variadic."
	"SimpleStackBasedCogit initializePrimitiveTableForSqueak"
	MaxCompiledPrimitiveIndex := self objectRepresentationClass wordSize = 8
										ifTrue: [555]
										ifFalse: [222].
	primitiveTable := CArrayAccessor on: (Array new: MaxCompiledPrimitiveIndex + 1).
	self table: primitiveTable from: 
	#(	"Integer Primitives (0-19)"
		(1 genPrimitiveAdd				1	mclassIsSmallInteger:)
		(2 genPrimitiveSubtract			1	mclassIsSmallInteger:)
		(3 genPrimitiveLessThan		1	mclassIsSmallInteger:)
		(4 genPrimitiveGreaterThan		1	mclassIsSmallInteger:)
		(5 genPrimitiveLessOrEqual		1	mclassIsSmallInteger:)
		(6 genPrimitiveGreaterOrEqual	1	mclassIsSmallInteger:)
		(7 genPrimitiveEqual			1	mclassIsSmallInteger:)
		(8 genPrimitiveNotEqual		1	mclassIsSmallInteger:)
		(9 genPrimitiveMultiply			1	processorHasMultiplyAndMClassIsSmallInteger:)
		(10 genPrimitiveDivide			1	processorHasDivQuoRemAndMClassIsSmallInteger:)
		(11 genPrimitiveMod			1	processorHasDivQuoRemAndMClassIsSmallInteger:)
		(12 genPrimitiveDiv				1	processorHasDivQuoRemAndMClassIsSmallInteger:)
		(13 genPrimitiveQuo			1	processorHasDivQuoRemAndMClassIsSmallInteger:)
		(14 genPrimitiveBitAnd			1	mclassIsSmallInteger:)
		(15 genPrimitiveBitOr			1	mclassIsSmallInteger:)
		(16 genPrimitiveBitXor			1	mclassIsSmallInteger:)
		(17 genPrimitiveBitShift			1	mclassIsSmallInteger:)
		"(18 primitiveMakePoint)"
		"(19 primitiveFail)"					"Guard primitive for simulation -- *must* fail"

		"LargeInteger Primitives (20-39)"
		"(20 primitiveFail)"
		"(21 primitiveAddLargeIntegers)"
		"(22 primitiveSubtractLargeIntegers)"
		"(23 primitiveLessThanLargeIntegers)"
		"(24 primitiveGreaterThanLargeIntegers)"
		"(25 primitiveLessOrEqualLargeIntegers)"
		"(26 primitiveGreaterOrEqualLargeIntegers)"
		"(27 primitiveEqualLargeIntegers)"
		"(28 primitiveNotEqualLargeIntegers)"
		"(29 primitiveMultiplyLargeIntegers)"
		"(30 primitiveDivideLargeIntegers)"
		"(31 primitiveModLargeIntegers)"
		"(32 primitiveDivLargeIntegers)"
		"(33 primitiveQuoLargeIntegers)"
		"(34 primitiveBitAndLargeIntegers)"
		"(35 primitiveBitOrLargeIntegers)"
		"(36 primitiveBitXorLargeIntegers)"
		"(37 primitiveBitShiftLargeIntegers)"

		"Float Primitives (38-59)"
		"(38 genPrimitiveFloatAt)"
		"(39 genPrimitiveFloatAtPut)"
		(40 genPrimitiveAsFloat					0	processorHasDoublePrecisionFloatingPointSupport:)
		(41 genPrimitiveFloatAdd				1	processorHasDoublePrecisionFloatingPointSupport:)
		(42 genPrimitiveFloatSubtract			1	processorHasDoublePrecisionFloatingPointSupport:)
		(43 genPrimitiveFloatLessThan			1	processorHasDoublePrecisionFloatingPointSupport:)
		(44 genPrimitiveFloatGreaterThan		1	processorHasDoublePrecisionFloatingPointSupport:)
		(45 genPrimitiveFloatLessOrEqual		1	processorHasDoublePrecisionFloatingPointSupport:)
		(46 genPrimitiveFloatGreaterOrEqual	1	processorHasDoublePrecisionFloatingPointSupport:)
		(47 genPrimitiveFloatEqual				1	processorHasDoublePrecisionFloatingPointSupport:)
		(48 genPrimitiveFloatNotEqual			1	processorHasDoublePrecisionFloatingPointSupport:)
		(49 genPrimitiveFloatMultiply			1	processorHasDoublePrecisionFloatingPointSupport:)
		(50 genPrimitiveFloatDivide				1	processorHasDoublePrecisionFloatingPointSupport:)
		"(51 genPrimitiveTruncated)"
		"(52 genPrimitiveFractionalPart)"
		"(53 genPrimitiveExponent)"
		"(54 genPrimitiveTimesTwoPower)"
		(55 genPrimitiveFloatSquareRoot		0	processorHasDoublePrecisionFloatingPointSupport:)
		"(56 genPrimitiveSine)"
		"(57 genPrimitiveArctan)"
		"(58 genPrimitiveLogN)"
		"(59 genPrimitiveExp)"

		"Subscript and Stream Primitives (60-67)"
		(60 genPrimitiveAt				1)
		(61 genPrimitiveAtPut			2)
		(62 genPrimitiveSize			0)
		(63 genPrimitiveStringAt		1)
		(64 genPrimitiveStringAtPut		2)
		"The stream primitives no longer pay their way; normal Smalltalk code is faster."
		(65 genFastPrimFail)"was primitiveNext"
		(66 genFastPrimFail) "was primitiveNextPut"
		(67 genFastPrimFail) "was primitiveAtEnd"

		"StorageManagement Primitives (68-79)"
		(68 genPrimitiveObjectAt			1)	"Good for debugger/InstructionStream performance"
		"(69 primitiveObjectAtPut)"
		(70 genPrimitiveNew			0)
		(71 genPrimitiveNewWithArg	1)
		"(72 primitiveArrayBecomeOneWay)"		"Blue Book: primitiveBecome"
		"(73 primitiveInstVarAt)"
		"(74 primitiveInstVarAtPut)"
		(75 genPrimitiveIdentityHash	0)
		"(76 primitiveStoreStackp)"					"Blue Book: primitiveAsObject"
		"(77 primitiveSomeInstance)"
		"(78 primitiveNextInstance)"
		(79 genPrimitiveNewMethod	2)

		"Control Primitives (80-89)"
		"(80 primitiveFail)"							"Blue Book: primitiveBlockCopy"
		"(81 primitiveFail)"							"Blue Book: primitiveValue"
		"(82 primitiveFail)"							"Blue Book: primitiveValueWithArgs"
		(83 genPrimitivePerform)
		"(84 primitivePerformWithArgs)"
		"(85 primitiveSignal)"
		"(86 primitiveWait)"
		"(87 primitiveResume)"
		"(88 primitiveSuspend)"
		"(89 primitiveFlushCache)"

		"System Primitives (110-119)"
		(110 genPrimitiveIdentical 1)
		(111 genPrimitiveClass)				"Support both class and Context>>objectClass:"
		"(112 primitiveBytesLeft)"
		"(113 primitiveQuit)"
		"(114 primitiveExitToDebugger)"
		"(115 primitiveChangeClass)"					"Blue Book: primitiveOopsLeft"
		"(116 primitiveFlushCacheByMethod)"
		"(117 primitiveExternalCall)"
		"(118 primitiveDoPrimitiveWithArgs)"
		"(119 primitiveFlushCacheSelective)"

		(169 genPrimitiveNotIdentical 1)

		(170 genPrimitiveAsCharacter)			"SmallInteger>>asCharacter, Character class>>value:"
		(171 genPrimitiveCharacterValue 0)	"Character>>value"
			
		"(173 primitiveSlotAt 1)"
		"(174 primitiveSlotAtPut 2)"
		(175 genPrimitiveIdentityHash	0)		"Behavior>>identityHash"

		"Old closure primitives"
		"(186 primitiveFail)" "was primitiveClosureValue"
		"(187 primitiveFail)" "was primitiveClosureValueWithArgs"

		"Perform method directly"
		"(188 primitiveExecuteMethodArgsArray)"
		"(189 primitiveExecuteMethod)"

		"Unwind primitives"
		"(195 primitiveFindNextUnwindContext)"
		"(196 primitiveTerminateTo)"
		"(197 primitiveFindHandlerContext)"
		(198 genFastPrimFail "primitiveMarkUnwindMethod")
		(199 genFastPrimFail "primitiveMarkHandlerMethod")

		"new closure primitives"
		"(200 primitiveClosureCopyWithCopiedValues)"
		(201 genPrimitiveClosureValue	0) "value"
		(202 genPrimitiveClosureValue	1) "value:"
		(203 genPrimitiveClosureValue	2) "value:value:"
		(204 genPrimitiveClosureValue	3) "value:value:value:"
		(205 genPrimitiveClosureValue	4) "value:value:value:value:"
		"(206 genPrimitiveClosureValueWithArgs)" "valueWithArguments:"

		"(210 primitiveContextAt)"
		"(211 primitiveContextAtPut)"
		"(212 primitiveContextSize)"

		"(218 primitiveDoNamedPrimitiveWithArgs)"
		"(219 primitiveFail)"	"reserved for Cog primitives"

		"(220 primitiveFail)"		"reserved for Cog primitives"

		(221 genPrimitiveClosureValue	0) "valueNoContextSwitch"
		(222 genPrimitiveClosureValue	1) "valueNoContextSwitch:"

		"SmallFloat primitives (540-559)"
		(541 genPrimitiveSmallFloatAdd				1	processorHasDoublePrecisionFloatingPointSupport:)
		(542 genPrimitiveSmallFloatSubtract			1	processorHasDoublePrecisionFloatingPointSupport:)
		(543 genPrimitiveSmallFloatLessThan			1	processorHasDoublePrecisionFloatingPointSupport:)
		(544 genPrimitiveSmallFloatGreaterThan		1	processorHasDoublePrecisionFloatingPointSupport:)
		(545 genPrimitiveSmallFloatLessOrEqual		1	processorHasDoublePrecisionFloatingPointSupport:)
		(546 genPrimitiveSmallFloatGreaterOrEqual		1	processorHasDoublePrecisionFloatingPointSupport:)
		(547 genPrimitiveSmallFloatEqual				1	processorHasDoublePrecisionFloatingPointSupport:)
		(548 genPrimitiveSmallFloatNotEqual			1	processorHasDoublePrecisionFloatingPointSupport:)
		(549 genPrimitiveSmallFloatMultiply				1	processorHasDoublePrecisionFloatingPointSupport:)
		(550 genPrimitiveSmallFloatDivide				1	processorHasDoublePrecisionFloatingPointSupport:)
		"(551 genPrimitiveSmallFloatTruncated			0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(552 genPrimitiveSmallFloatFractionalPart		0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(553 genPrimitiveSmallFloatExponent			0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(554 genPrimitiveSmallFloatTimesTwoPower	1	processorHasDoublePrecisionFloatingPointSupport:)"
		(555 genPrimitiveSmallFloatSquareRoot			0	processorHasDoublePrecisionFloatingPointSupport:)
		"(556 genPrimitiveSmallFloatSine				0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(557 genPrimitiveSmallFloatArctan				0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(558 genPrimitiveSmallFloatLogN				0	processorHasDoublePrecisionFloatingPointSupport:)"
		"(559 genPrimitiveSmallFloatExp				0	processorHasDoublePrecisionFloatingPointSupport:)"
	)