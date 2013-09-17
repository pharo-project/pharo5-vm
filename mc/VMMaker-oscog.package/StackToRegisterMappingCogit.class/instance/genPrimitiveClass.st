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
	objectRepresentation
		genGetClassObjectOf: reg
		into: ReceiverResultReg
		scratchReg: TempReg.
	self RetN: 0.
	^0