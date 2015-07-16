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

	self numRegArgs + 1 = numArgs ifTrue:
		[backEnd hasLinkRegister
			ifTrue:
				[self numRegArgs = 2 ifTrue:
					[self PopR: Arg1Reg].
				 self PopR: Arg0Reg]
			ifFalse:
				[self PopR: TempReg. "save retpc"
				 self numRegArgs = 2 ifTrue:
					[self PopR: Arg1Reg].
				 self MoveMw: 0 r: SPReg R: Arg0Reg.
				 self MoveR: TempReg Mw: 0 r: SPReg].
		 ^self].

	"e.g.	Receiver				Receiver
			Selector/Arg0	=>		Arg1
			Arg1					Arg2
	 		Arg2			sp->	Arg3
	 sp->	Arg3"
	super adjustArgumentsForPerform: numArgs