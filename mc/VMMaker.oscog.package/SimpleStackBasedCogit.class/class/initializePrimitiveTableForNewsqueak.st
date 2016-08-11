class initialization
initializePrimitiveTableForNewsqueak
	"Initialize the table of primitive generators.  This does not include normal primitives implemented in the coInterpreter.
	 N.B. primitives that don't have an explicit arg count (the integer following the generator) may be variadic."
	"SimpleStackBasedCogit initializePrimitiveTableForNewsqueak"
	MaxCompiledPrimitiveIndex := self objectRepresentationClass wordSize = 8
										ifTrue: [555]
										ifFalse: [222].
	primitiveTable := CArrayAccessor on: (Array new: MaxCompiledPrimitiveIndex + 1).
	self table: primitiveTable from: 
	#(	"Integer Primitives (0-19)"
		(1 genPrimitiveAdd				1)
		(2 genPrimitiveSubtract			1)
		(3 genPrimitiveLessThan		1)
		(4 genPrimitiveGreaterThan		1)
		(5 genPrimitiveLessOrEqual		1)
		(6 genPrimitiveGreaterOrEqual	1)
		(7 genPrimitiveEqual			1)
		(8 genPrimitiveNotEqual		1)
		(9 genPrimitiveMultiply			1)
		(10 genPrimitiveDivide			1)
		(11 genPrimitiveMod			1)
		(12 genPrimitiveDiv				1)
		(13 genPrimitiveQuo			1)
		(14 genPrimitiveBitAnd			1)
		(15 genPrimitiveBitOr			1)
		(16 genPrimitiveBitXor			1)
		(17 genPrimitiveBitShift			1)
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
		(40 genPrimitiveAsFloat					0)
		(41 genPrimitiveFloatAdd				1)
		(42 genPrimitiveFloatSubtract			1)
		(43 genPrimitiveFloatLessThan			1)
		(44 genPrimitiveFloatGreaterThan		1)
		(45 genPrimitiveFloatLessOrEqual		1)
		(46 genPrimitiveFloatGreaterOrEqual	1)
		(47 genPrimitiveFloatEqual				1)
		(48 genPrimitiveFloatNotEqual			1)
		(49 genPrimitiveFloatMultiply			1)
		(50 genPrimitiveFloatDivide				1)
		"(51 genPrimitiveTruncated)"
		"(52 genPrimitiveFractionalPart)"
		"(53 genPrimitiveExponent)"
		"(54 genPrimitiveTimesTwoPower)"
		(55 genPrimitiveFloatSquareRoot		0)
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
		(70 genPrimitiveNew)				"For VMMirror support 1 argument instantiateFixedClass: as well as baiscNew"
		(71 genPrimitiveNewWithArg)		"For VMMirror support 2 argument instantiateVariableClass:withSize: as well as baiscNew:"
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
		(111 genPrimitiveClass)			"For objectClass: and VMMirror support 1 argument classOf: as well as class"
		"(112 primitiveBytesLeft)"
		"(113 primitiveQuit)"
		"(114 primitiveExitToDebugger)"
		"(115 primitiveChangeClass)"					"Blue Book: primitiveOopsLeft"
		"(116 primitiveFlushCacheByMethod)"
		"(117 primitiveExternalCall)"
		"(118 primitiveDoPrimitiveWithArgs)"
		"(119 primitiveFlushCacheSelective)"

		(148 genPrimitiveShallowCopy 0)			"a.k.a. clone"

		(169 genPrimitiveNotIdentical 1)

		(170 genPrimitiveAsCharacter)				"SmallInteger>>asCharacter, Character class>>value:"
		(171 genPrimitiveImmediateAsInteger 0)	"Character>>value SmallFloat64>>asInteger"
			
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
		(541 genPrimitiveSmallFloatAdd				1)
		(542 genPrimitiveSmallFloatSubtract			1)
		(543 genPrimitiveSmallFloatLessThan			1)
		(544 genPrimitiveSmallFloatGreaterThan		1)
		(545 genPrimitiveSmallFloatLessOrEqual		1)
		(546 genPrimitiveSmallFloatGreaterOrEqual		1)
		(547 genPrimitiveSmallFloatEqual				1)
		(548 genPrimitiveSmallFloatNotEqual			1)
		(549 genPrimitiveSmallFloatMultiply				1)
		(550 genPrimitiveSmallFloatDivide				1)
		"(551 genPrimitiveSmallFloatTruncated			0)"
		"(552 genPrimitiveSmallFloatFractionalPart		0)"
		"(553 genPrimitiveSmallFloatExponent			0)"
		"(554 genPrimitiveSmallFloatTimesTwoPower	1)"
		(555 genPrimitiveSmallFloatSquareRoot			0)
		"(556 genPrimitiveSmallFloatSine				0)"
		"(557 genPrimitiveSmallFloatArctan				0)"
		"(558 genPrimitiveSmallFloatLogN				0)"
		"(559 genPrimitiveSmallFloatExp				0)"
	)