object testing
isIntegerObject: oop
	"This list records the valid senders of isIntegerObject: as we replace uses of
	  isIntegerObject: by isImmediate: where appropriate."
	| sel |
	sel := thisContext sender method selector.
	(#(	DoIt
		DoItIn:
		on:do: "from the debugger"
		makeBaseFrameFor:
		quickFetchInteger:ofObject:
		frameOfMarriedContext:
		objCouldBeClassObj:
		isMarriedOrWidowedContext:
		shortPrint:
		bytecodePrimAt
		bytecodePrimAtPut
		commonAt:
		commonAtPut:
		loadFloatOrIntFrom:
		positive32BitValueOf:
		primitiveExternalCall
		checkedIntegerValueOf:
		bytecodePrimAtPut
		commonAtPut:
		primitiveVMParameter
		checkIsStillMarriedContext:currentFP:
		displayBitsOf:Left:Top:Right:Bottom:
		fetchStackPointerOf:
		primitiveContextAt
		primitiveContextAtPut
		subscript:with:storing:format:
		printContext:
		compare31or32Bits:equal:
		signed64BitValueOf:
		primDigitMultiply:negative:
		digitLength:
		isNegativeIntegerValueOf:
		magnitude64BitValueOf:
		primitiveMakePoint
		primitiveAsCharacter
		primitiveInputSemaphore
		baseFrameReturn
		primitiveExternalCall
		primDigitCompare:
		isLiveContext:
		numPointerSlotsOf:
		fileValueOf:
		loadBitBltDestForm
		fetchIntOrFloat:ofObject:ifNil:
		fetchIntOrFloat:ofObject:
		loadBitBltSourceForm
		loadPoint:from:
		primDigitAdd:
		primDigitSubtract:
		positive64BitValueOf:
		digitBitLogic:with:opIndex:
		signed32BitValueOf:
		isNormalized:
		primDigitDiv:negative:) includes: sel) ifFalse:
		[self halt].
	^(oop bitAnd: 1) ~= 0