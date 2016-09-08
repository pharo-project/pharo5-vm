control primitives
primitiveClosureCopyWithCopiedValues
	| newClosure copiedValues numCopiedValues numArgs |
	numArgs := self stackIntegerValue: 1.
	copiedValues := self stackTop.
	self success: (self fetchClassOf: copiedValues) = (self splObj: ClassArray).
	successFlag ifFalse:
		[^self primitiveFail].
	numCopiedValues := self numSlotsOf: copiedValues.
	newClosure := self
					closureNumArgs: numArgs
									"greater by 1 due to preIncrement of localIP"
					instructionPointer: instructionPointer + 2 - (method+self baseHeaderSize)
					numCopiedValues: numCopiedValues.
	"Assume: have just allocated a new closure; it must be young. Thus, can use unchecked stores."
	self storePointerUnchecked: ClosureOuterContextIndex ofObject: newClosure withValue: (self stackValue: 2).
	numCopiedValues > 0 ifTrue:
		["Allocation may have done a GC and copiedValues may have moved."
		 copiedValues := self stackTop.
		 0 to: numCopiedValues - 1 do:
			[:i|
			"Assume: have just allocated a new BlockClosure; it must be young.
			 Thus, can use unchecked stores."
			 self storePointerUnchecked: i + ClosureFirstCopiedValueIndex
				ofObject: newClosure
				withValue: (self fetchPointer: i ofObject: copiedValues)]].
	self pop: 3 thenPush: newClosure