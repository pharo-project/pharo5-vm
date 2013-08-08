bytecode generators
genSendAbsentImplicit: selector numArgs: numArgs
	"Get the implicit receiver and shuffle arguments if necessary.
	 Then send."
	<inline: false>
	| result |
	result := self genGetImplicitReceiverFor: selector forPush: false.
	result ~= 0 ifTrue:
		[^result].
	numArgs = 0
		ifTrue:
			[self PushR: ReceiverResultReg]
		ifFalse:
			[self MoveMw: 0 r: SPReg R: TempReg.
			self PushR: TempReg.
			2 to: numArgs do:
				[:index|
				self MoveMw: index * BytesPerWord r: SPReg R: TempReg.
				self MoveR: TempReg Mw: index - 1 * BytesPerWord r: SPReg].
			"if we copied the code in genSend:numArgs: we could save an instruction.
			But we care not; the smarts are in StackToRegisterMappingCogit et al"
			self MoveR: ReceiverResultReg Mw: numArgs * BytesPerWord r: SPReg].
	^self genSend: selector numArgs: numArgs