primitive generators
adjustArgumentsForPerform: numArgs
	"e.g.	Receiver				Receiver	or	Receiver				Receiver	(RISC)
			Selector/Arg0	=>		Arg1			Selector/Arg0	=>		Arg1
			Arg1					Arg2			Arg1					Arg2
			Arg2					Arg3			Arg2			sp->	Arg3
	 		Arg3			sp->	retpc	sp->	Arg3
	 sp->	retpc"

	backEnd hasLinkRegister
		ifTrue:
			[numArgs - 2 to: 0 by: -1 do:
				[:index|
				self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
				self MoveR: TempReg Mw: index + 1 * objectMemory wordSize r: SPReg].
			self AddCq: objectMemory wordSize R: SPReg]
		ifFalse:
			[numArgs - 1 to: 1 by: -1 do:
				[:index|
				self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
				self MoveR: TempReg Mw: index + 1 * objectMemory wordSize r: SPReg].
			self PopR: TempReg.
			self MoveR: TempReg Mw: 0 r: SPReg]