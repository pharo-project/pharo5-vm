primitive generators
compileMachineCodeInterpreterPrimitive: primitiveRoutine
	"Compile a call to a machine-code convention interpreter primitive.  Call the C routine
	 on the Smalltalk stack, assuming it consumes little or no stack space."
	<var: #primitiveRoutine declareC: 'void (*primitiveRoutine)(void)'>
	| jmpFail liveRegsMask |
	"for now handle functions with less than 4 arguments; our C call marshalling machinery
	 extends up to 4 arguments only, and the first argument of an mcprim is the receiver."
	self assert: methodOrBlockNumArgs <= 3.
	liveRegsMask := (methodOrBlockNumArgs > self numRegArgs
					   or: [methodOrBlockNumArgs = 0])
						ifTrue:
							[self registerMaskFor: ReceiverResultReg]
						ifFalse:
							[(self numRegArgs > 1 and: [methodOrBlockNumArgs > 1])
								ifFalse: [self registerMaskFor: ReceiverResultReg and: Arg0Reg]
								ifTrue: [self registerMaskFor: ReceiverResultReg and: Arg0Reg and: Arg1Reg]].
	backEnd genSaveRegs: (liveRegsMask bitAnd: CallerSavedRegisterMask).
	methodOrBlockNumArgs > self numRegArgs ifTrue:
		["Wrangle args into Arg0Reg, Arg1Reg, SendNumArgsReg & ClassReg"
		 "offset := self bitCountOf: (liveRegsMask bitAnd: CallerSavedRegisterMask)."
		 self shouldBeImplemented].
	backEnd
		genMarshallNArgs: methodOrBlockNumArgs + 1
		arg: ReceiverResultReg
		arg: Arg0Reg
		arg: Arg1Reg
		arg: SendNumArgsReg
		"arg: ClassReg (when we extend C call marchalling to support 5 args for replaceFrom:to:with:startingAt:".
	self CallFullRT: primitiveRoutine asInteger.
	backEnd
		genRemoveNArgsFromStack: methodOrBlockNumArgs + 1;
		genRestoreRegs: (liveRegsMask bitAnd: CallerSavedRegisterMask).
	self CmpCq: 0 R: backEnd cResultRegister.
	jmpFail := self JumpZero: 0.
	backEnd cResultRegister ~= ReceiverResultReg ifTrue:
		[self MoveR: backEnd cResultRegister R: ReceiverResultReg].
	self RetN: (methodOrBlockNumArgs > self numRegArgs
				ifTrue: [methodOrBlockNumArgs + 1 * objectMemory wordSize]
				ifFalse: [0]).
	jmpFail jmpTarget: self Label.
	^0