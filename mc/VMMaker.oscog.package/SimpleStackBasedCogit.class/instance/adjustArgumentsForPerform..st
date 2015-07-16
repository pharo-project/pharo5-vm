primitive generators
adjustArgumentsForPerform: numArgs
	"e.g.	Receiver				Receiver
			Selector/Arg0	=>		Arg1
			Arg1					Arg2
	 		Arg2			sp->	retpc
	 sp->	retpc"

	self break.
	(backEnd hasLinkRegister ifTrue: [numArgs - 2] ifFalse: [numArgs - 1]) to: 0 by: -1 do:
		[:index|
		self MoveMw: index * objectMemory wordSize r: SPReg R: TempReg.
		self MoveR: TempReg Mw: index + 1 * objectMemory wordSize r: SPReg].
	self PopR: TempReg.
	self MoveR: TempReg Mw: 0 r: SPReg