primitive generators
genPrimitiveClass
	"Depending on argument count the argument is either
		0 args: ReceiverResultReg
		1 args: Arg0Reg
		N args: top of stack (assuming 1 reg arg for now)"
	| reg |
	methodOrBlockNumArgs = 1
		ifTrue:
			[reg := Arg0Reg]
		ifFalse:
			[methodOrBlockNumArgs > 0 ifTrue:
				[self MoveMw: BytesPerWord r: SPReg R: ReceiverResultReg].
			reg := ReceiverResultReg].
	(objectRepresentation
			genGetClassObjectOf: reg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0) = BadRegisterSet ifTrue:
		[objectRepresentation
			genGetClassObjectOf: reg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0.
		 self MoveR: ClassReg R: ReceiverResultReg].
	self RetN: 0.
	^0