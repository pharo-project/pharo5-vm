primitive generators
adjustArgumentsForPerform: numArgs
	"Generate code to adjust the possibly stacked arguments immediately
	 before jumping to a method looked up by a perform primitive."
	self assert: self numRegArgs <= 2.
	self assert: numArgs >= 1.
	numArgs <= self numRegArgs ifTrue:
		[numArgs = 2 ifTrue:
			[self MoveR: Arg1Reg R: Arg0Reg].
		 ^self].

	"If the arity is one more than the max numRegArgs, the receiver and all arguments have to be removed from the stack."
	self numRegArgs + 1 = numArgs ifTrue:
		[backEnd hasLinkRegister
			ifTrue:
				[self numRegArgs = 2
					ifTrue:
						[self MoveMw: 0 r: SPReg R: Arg1Reg.
						 self MoveMw: objectMemory wordSize r: SPReg R: Arg0Reg]
					ifFalse:
						[self MoveMw: 0 r: SPReg R: Arg0Reg].
				 self AddCq: numArgs + 1 * objectMemory wordSize R: SPReg]
			ifFalse:
				[self MoveMw: 0 r: SPReg R: TempReg. "save retpc"
				 self numRegArgs = 2
					ifTrue:
						[self MoveMw: objectMemory wordSize r: SPReg R: Arg1Reg.
						 self MoveMw: objectMemory wordSize * 2 r: SPReg R: Arg0Reg]
					ifFalse:
						[self MoveMw: objectMemory wordSize r: SPReg R: Arg0Reg].
				 self AddCq: numArgs + 1 * objectMemory wordSize R: SPReg.
				 self MoveR: TempReg Mw: 0 r: SPReg "Overwrite pushed receiver; ReceiverResultReg already contains receiver."].
		 ^self].

	"e.g.	Receiver				Receiver
			Selector/Arg0	=>		Arg1
			Arg1					Arg2
	 		Arg2			sp->	Arg3
	 sp->	Arg3"
	super adjustArgumentsForPerform: numArgs