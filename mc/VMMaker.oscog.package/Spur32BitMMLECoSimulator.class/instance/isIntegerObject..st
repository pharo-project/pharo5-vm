object testing
isIntegerObject: oop
	"This list records the valid senders of isIntegerObject: as we replace uses of
	  isIntegerObject: by isImmediate: where appropriate."
	| sel |
	sel := thisContext sender method selector.
	(#(	DoIt
		DoItIn:
		baseFrameReturn
		bereaveAllMarriedContextsForSnapshotFlushingExternalPrimitivesIf:
		bytecodePrimAt
		bytecodePrimAtPut
		bytesOrInt:growTo:
		ceBaseFrameReturn:
		checkIsStillMarriedContext:currentFP:
		checkedIntegerValueOf:
		cogMethodDoesntLookKosher:
		commonAt:
		commonAtPut:
		commonVariable:at:put:cacheIndex:
		compare31or32Bits:equal:
		digitBitLogic:with:opIndex:
		digitLength:
		displayBitsOf:Left:Top:Right:Bottom:
		ensureContextHasBytecodePC:
		externalInstVar:ofContext:
		fetchIntOrFloat:ofObject:
		fetchIntOrFloat:ofObject:ifNil:
		fetchStackPointerOf:
		fileValueOf:
		frameOfMarriedContext:
		functionForPrimitiveExternalCall:
		genSpecialSelectorArithmetic
		genSpecialSelectorComparison
		inlineCacheTagForInstance:
		instVar:ofContext:
		isCogMethodReference:
		isLiveContext:
		isMarriedOrWidowedContext:
		isNegativeIntegerValueOf:
		isNormalized:
		loadBitBltDestForm
		loadBitBltSourceForm
		loadFloatOrIntFrom:
		loadPoint:from:
		magnitude64BitValueOf:
		makeBaseFrameFor:
		numPointerSlotsOf:
		objCouldBeClassObj:
		on:do: "from the debugger"
		positive32BitValueOf:
		positive64BitValueOf:
		primDigitAdd:
		primDigitBitShiftMagnitude:
		primDigitCompare:
		primDigitDiv:negative:
		primDigitMultiply:negative:
		primDigitSubtract:
		primitiveAllInstances
		primitiveAsCharacter
		primitiveContextAt
		primitiveContextAtPut
		primitiveExternalCall
		primitiveFileSetPosition
		primitiveFileTruncate	DoIt
		primitiveForwardSignalToSemaphore
		primitiveGrowMemoryByAtLeast
		primitiveInputSemaphore
		primitiveMakePoint
		primitiveNewMethod
		primitiveObjectAtPut
		primitiveSizeInBytesOfInstance
		primitiveVMParameter
		printContext:
		quickFetchInteger:ofObject:
		shortPrint:
		shortPrintOop:
		signed32BitValueOf:
		signed64BitValueOf:
		subscript:with:storing:format:
		unlockSurfaces
		establishFrameForContextToReturnTo:) includes: sel) ifFalse:
		[self halt].
	^super isIntegerObject: oop