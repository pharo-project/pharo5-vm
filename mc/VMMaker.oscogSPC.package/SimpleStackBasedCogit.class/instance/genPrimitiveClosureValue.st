primitive generators
genPrimitiveClosureValue
	"Check the argument count.  Fail if wrong.
	 Get the method from the outerContext and see if it is cogged.  If so, jump to the
	 block entry or the no-context-switch entry, as appropriate, and we're done.  If not,
	 invoke the interpreter primitive."
	| jumpFailNArgs jumpFail1 jumpFail2 jumpFail3 jumpFail4 jumpBCMethod primitiveRoutine result |
	<var: #jumpFail1 type: #'AbstractInstruction *'>
	<var: #jumpFail2 type: #'AbstractInstruction *'>
	<var: #jumpFail3 type: #'AbstractInstruction *'>
	<var: #jumpFail4 type: #'AbstractInstruction *'>
	<var: #jumpFailNArgs type: #'AbstractInstruction *'>
	<var: #jumpBCMethod type: #'AbstractInstruction *'>
	<var: #primitiveRoutine declareC: 'void (*primitiveRoutine)()'>
	objectRepresentation genLoadSlot: ClosureNumArgsIndex sourceReg: ReceiverResultReg destReg: TempReg.
	self CmpCq: (objectMemory integerObjectOf: methodOrBlockNumArgs) R: TempReg.
	jumpFailNArgs := self JumpNonZero: 0.
	objectRepresentation genLoadSlot: ClosureOuterContextIndex sourceReg: ReceiverResultReg destReg: ClassReg.
	jumpFail1 := objectRepresentation genJumpImmediate: ClassReg.
	objectRepresentation genGetCompactClassIndexNonImmOf: ClassReg into: TempReg.
	objectRepresentation genCmpClassMethodContextCompactIndexR: TempReg.
	jumpFail2 := self JumpNonZero: 0.
	"We defer unforwarding the receiver to the prologue; scanning blocks
	 for inst var refs and only unforwarding if the block refers to inst vars."
	(false
	 and: [objectRepresentation hasSpurMemoryManagerAPI]) ifTrue:
		[objectRepresentation
			genLoadSlot: ReceiverIndex sourceReg: ClassReg destReg: SendNumArgsReg;
			genEnsureOopInRegNotForwarded: SendNumArgsReg
			scratchReg: TempReg
			updatingSlot: ReceiverIndex
			in: ClassReg].
	objectRepresentation genLoadSlot: MethodIndex sourceReg: ClassReg destReg: SendNumArgsReg.
	jumpFail3 := objectRepresentation genJumpImmediate: SendNumArgsReg.
	objectRepresentation genGetFormatOf: SendNumArgsReg into: TempReg.
	self CmpCq: objectMemory firstCompiledMethodFormat R: TempReg.
	jumpFail4 := self JumpLess: 0.
	objectRepresentation genLoadSlot: HeaderIndex sourceReg: SendNumArgsReg destReg: ClassReg.
	jumpBCMethod := objectRepresentation genJumpImmediate: ClassReg.
	self MoveM16: (self offset: CogMethod of: #blockEntryOffset) r: ClassReg R: TempReg.
	self AddR: ClassReg R: TempReg.
	primitiveRoutine := coInterpreter
							functionPointerForCompiledMethod: methodObj
							primitiveIndex: primitiveIndex.
	primitiveRoutine = #primitiveClosureValueNoContextSwitch ifTrue:
		[blockNoContextSwitchOffset = nil ifTrue:
			[^NotFullyInitialized].
		 self SubCq: blockNoContextSwitchOffset R: TempReg].
	self JumpR: TempReg.
	jumpBCMethod jmpTarget: (jumpFail1 jmpTarget: (jumpFail2 jmpTarget: (jumpFail3 jmpTarget: (jumpFail4 jmpTarget: self Label)))).
	(result := self compileInterpreterPrimitive: primitiveRoutine) < 0 ifTrue:
		[^result].
	jumpFailNArgs jmpTarget: self Label.
	^CompletePrimitive