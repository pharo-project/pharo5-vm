primitive generators
genPrimitiveFullClosureValue
	"Check the argument count.  Fail if wrong.
	 Get the method from the outerContext and see if it is cogged.  If so, jump to the
	 block entry or the no-context-switch entry, as appropriate, and we're done.  If not,
	 invoke the interpreter primitive."
	| jumpFailNArgs jumpFailImmediateMethod jumpFail4 jumpBCMethod primitiveRoutine result |
	<option: #SistaV1BytecodeSet>
	<var: #jumpFailImmediateMethod type: #'AbstractInstruction *'>
	<var: #jumpFail4 type: #'AbstractInstruction *'>
	<var: #jumpFailNArgs type: #'AbstractInstruction *'>
	<var: #jumpBCMethod type: #'AbstractInstruction *'>
	<var: #primitiveRoutine declareC: 'void (*primitiveRoutine)()'>
	objectRepresentation genLoadSlot: ClosureNumArgsIndex sourceReg: ReceiverResultReg destReg: TempReg.
	self CmpCq: (objectMemory integerObjectOf: methodOrBlockNumArgs) R: TempReg.
	jumpFailNArgs := self JumpNonZero: 0.

	"We defer unforwarding the receiver to the prologue; scanning blocks
	 for inst var refs and only unforwarding if the block refers to inst vars."
	(false
	 and: [objectRepresentation hasSpurMemoryManagerAPI]) ifTrue:
		[objectRepresentation
			genLoadSlot: FullClosureReceiverIndex sourceReg: ReceiverResultReg destReg: SendNumArgsReg;
			genEnsureOopInRegNotForwarded: SendNumArgsReg
			scratchReg: TempReg
			updatingSlot: FullClosureReceiverIndex
			in: ReceiverResultReg].
	objectRepresentation genLoadSlot: FullClosureCompiledBlockIndex sourceReg: ReceiverResultReg destReg: SendNumArgsReg.
	jumpFailImmediateMethod := objectRepresentation genJumpImmediate: SendNumArgsReg.
	objectRepresentation genGetFormatOf: SendNumArgsReg into: TempReg.
	self CmpCq: objectMemory firstCompiledMethodFormat R: TempReg.
	jumpFail4 := self JumpLess: 0.
	objectRepresentation genLoadSlot: HeaderIndex sourceReg: SendNumArgsReg destReg: ClassReg.
	jumpBCMethod := objectRepresentation genJumpImmediate: ClassReg.

	primitiveRoutine := coInterpreter
							functionPointerForCompiledMethod: methodObj
							primitiveIndex: primitiveIndex.
	self AddCq: (primitiveRoutine = #primitiveFullClosureValueNoContextSwitch
					ifTrue: [self fullBlockNoContextSwitchEntryOffset]
					ifFalse: [self fullBlockEntryOffset])
		 R: ClassReg.
	self JumpR: ClassReg.
	jumpBCMethod jmpTarget: (jumpFailImmediateMethod jmpTarget: (jumpFail4 jmpTarget: self Label)).
	(result := self compileInterpreterPrimitive: primitiveRoutine) < 0 ifTrue:
		[^result].
	jumpFailNArgs jmpTarget: self Label.
	^CompletePrimitive