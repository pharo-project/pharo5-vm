bytecode generators
genSendAbsentDynamicSuper: selector numArgs: numArgs
	"Shuffle arguments if necessary and push receiver.
	 Then send."
	<inline: false>
	numArgs = 0
		ifTrue:
			[self PushR: ReceiverResultReg]
		ifFalse:
			[self MoveMw: 0 r: SPReg R: TempReg.
			self PushR: TempReg.
			2 to: numArgs do:
				[:index|
				self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
				self MoveR: TempReg Mw: index - 1 * objectMemory wordSize r: SPReg].
			"if we copied the code in genSendDynamicSuper: we could save an instruction.
			But we care not; the smarts are in StackToRegisterMappingCogit et al"
			self MoveR: ReceiverResultReg Mw: numArgs * objectMemory wordSize r: SPReg].
	^self genSendDynamicSuper: selector numArgs: numArgs